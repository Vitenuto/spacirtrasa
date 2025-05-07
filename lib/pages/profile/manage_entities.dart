import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/services/map_entity/map_entity.dart';
import 'package:spacirtrasa/widgets/async_button_handler.dart';

class ManageEntities<T extends MapEntity> extends ConsumerStatefulWidget {
  final MapEntityService entityService;
  final ProviderListenable<List<MapEntity>> provider;

  const ManageEntities(this.entityService, this.provider, {super.key});

  @override
  ConsumerState<ManageEntities> createState() => _ManageEntitiesState<T>();
}

class _ManageEntitiesState<T extends MapEntity> extends ConsumerState<ManageEntities> {
  final Set<String> _selectedIds = {};

  late List<MapEntity> mapEntities;

  get selectedEntites =>
      mapEntities.where((mapEntity) => _selectedIds.contains(mapEntity.id)).toList();

  @override
  Widget build(BuildContext context) {
    mapEntities = ref.watch(widget.provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isSelectionMode
              ? 'profile.manage_entities.selected-title'.tr(args: [_selectedIds.length.toString()])
              : 'profile.manage_entities.title.$T'.tr(),
        ),
        leading:
            _isSelectionMode
                ? IconButton(icon: const Icon(Icons.close), onPressed: _clearSelection)
                : null,
        actions: _buildActions(context),
      ),
      body: _buildListView(mapEntities),
      persistentFooterButtons: _buildExportButton(),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    if (_isSelectionMode) {
      return [
        IconButton(
          icon: Icon(
            _selectedIds.length == mapEntities.length ? Icons.select_all_outlined : Icons.done_all,
          ),
          tooltip:
              _selectedIds.length == mapEntities.length
                  ? 'profile.manage_entities.selected-none'.tr()
                  : 'profile.manage_entities.selected-all'.tr(),
          onPressed: () => _selectAll(mapEntities),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          tooltip: 'profile.manage_entities.delete-selected'.tr(),
          onPressed: () async => await _removeEntities(context),
        ),
      ];
    }

    return [
      MenuAnchor(
        builder: (context, controller, child) {
          return IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
          );
        },
        menuChildren: [
          MenuItemButton(
            onPressed: () async => await widget.entityService.addDummy(),
            child: Text('profile.manage_entities.add-dummy.$T'.tr()),
          ),
          MenuItemButton(
            onPressed: () async => await _importEntities(),
            child: Text('profile.manage_entities.import.$T'.tr()),
          ),
        ],
      ),
    ];
  }

  bool _isSelectionMode = false;

  void _toggleSelection(String id) {
    setState(() {
      _isSelectionMode = true;
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        if (_selectedIds.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedIds.add(id);
      }
    });
  }

  List<Widget>? _buildExportButton() {
    if (!_isSelectionMode) return null;

    return [
      ElevatedAsyncButton(
        onPressed: () async => await _exportEntities(mapEntities),
        child: Text('profile.manage_entities.export.$T'.tr()),
      ),
    ];
  }

  Future<void> _importEntities() async {
    final importedCount = await widget.entityService.importEntities();
    if (importedCount == 0) return;
    Fluttertoast.showToast(msg: 'profile.manage_entities.import-success.$T'.plural(importedCount));
  }

  Future<void> _exportEntities(List<MapEntity> mapEntities) async {
    final selectedDir = await widget.entityService.exportEntities(selectedEntites);
    if (selectedDir == null) return;
    Fluttertoast.showToast(
      msg: 'profile.manage_entities.export-success.$T'.plural(
        selectedEntites.length,
        args: [selectedDir],
      ),
    );
    _clearSelection();
  }

  void _clearSelection() {
    setState(() {
      _isSelectionMode = false;
      _selectedIds.clear();
    });
  }

  void _selectAll(List<MapEntity> mapEntities) {
    setState(() {
      final allSelected = _selectedIds.length == mapEntities.length;
      if (allSelected) {
        _selectedIds.clear();
      } else {
        _selectedIds.addAll(mapEntities.map((e) => e.id));
      }
    });
  }

  Widget _buildListView(List<MapEntity> mapEntities) {
    return mapEntities.isEmpty
        ? Center(child: Text('profile.manage_entities.no-entities-found.$T'.tr()))
        : ListView.builder(
          itemCount: mapEntities.length,
          itemBuilder: (context, index) {
            final mapEntity = mapEntities[index];
            final isSelected = _selectedIds.contains(mapEntity.id);

            return Dismissible(
              key: Key(mapEntity.id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: _isSelectionMode ? DismissDirection.none : DismissDirection.startToEnd,
              confirmDismiss: (_) async {
                return await _showConfirmDeleteDialog(context, itemName: mapEntity.title);
              },
              onDismissed: (_) async => _removeEntity(mapEntity),
              child: ListTile(
                title: Text(mapEntity.title),
                subtitle: Text('created'.tr(args: [mapEntity.createdAt.toDate().toString()])),
                trailing:
                    _isSelectionMode
                        ? Checkbox(
                          value: isSelected,
                          onChanged: (_) => _toggleSelection(mapEntity.id),
                        )
                        : null,
                onLongPress: () => _toggleSelection(mapEntity.id),
                onTap: _isSelectionMode ? () => _toggleSelection(mapEntity.id) : null,
              ),
            );
          },
        );
  }

  Future<bool> _showConfirmDeleteDialog(
    BuildContext context, {
    int? count,
    String? itemName,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('profile.manage_entities.delete-confirmation-title'.tr()),
                content: Text(
                  count != null
                      ? 'profile.manage_entities.delete-confirmation-message-multiple.$T'.plural(
                        count,
                      )
                      : 'profile.manage_entities.delete-confirmation-message-single'.tr(
                        args: [itemName ?? 'invalid'],
                      ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('cancel'.tr()),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('delete'.tr()),
                  ),
                ],
              ),
        ) ??
        false;
  }

  Future<void> _removeEntity(MapEntity mapEntity) async {
    await widget.entityService.removeEntity(mapEntity);
    Fluttertoast.showToast(
      msg: 'profile.manage_entities.delete-success-single.$T'.tr(args: [mapEntity.title]),
    );
  }

  Future<void> _removeEntities(BuildContext context) async {
    final confirm = await _showConfirmDeleteDialog(context, count: _selectedIds.length);
    if (confirm) {
      final removeEntitiesCount = selectedEntites.length;
      await widget.entityService.removeEntities(selectedEntites);
      Fluttertoast.showToast(
        msg: 'profile.manage_entities.delete-success-multiple.$T'.tr(
          args: [removeEntitiesCount.toString()],
        ),
      );
      _clearSelection();
    }
  }
}
