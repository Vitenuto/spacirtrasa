import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/map_entity.dart';
import '../../services/map_entity/map_entity_service.dart';

class ManageEntities<T extends MapEntity> extends ConsumerStatefulWidget {
  final MapEntityService entityService;
  final ProviderListenable<List<MapEntity>> provider;

  const ManageEntities(this.entityService, this.provider, {super.key});

  @override
  ConsumerState<ManageEntities> createState() => _ManageEntitiesState<T>();
}

class _ManageEntitiesState<T extends MapEntity> extends ConsumerState<ManageEntities> {
  final Set<String> _selectedIds = {};

  bool _isSelectionMode = false;

  void _toggleSelection(String id) {
    setState(() {
      _isSelectionMode = true;
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  late List<MapEntity> mapEntities;

  get selectedEntites =>
      mapEntities.where((mapEntity) => _selectedIds.contains(mapEntity.id)).toList();

  @override
  Widget build(BuildContext context) {
    mapEntities = ref.watch(widget.provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode ? '${_selectedIds.length} selected' : 'Manage ${T}s'),
        leading:
            _isSelectionMode
                ? IconButton(icon: const Icon(Icons.close), onPressed: _clearSelection)
                : null,
        actions: [
          if (_isSelectionMode)
            IconButton(
              icon: Icon(
                _selectedIds.length == mapEntities.length
                    ? Icons.select_all_outlined
                    : Icons.done_all,
              ),
              tooltip: _selectedIds.length == mapEntities.length ? 'Deselect All' : 'Select All',
              onPressed: () => _selectAll(mapEntities),
            ),
          if (_isSelectionMode)
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete Selected',
              onPressed: () async => await _removeEntities(context),
            ),
        ],
      ),
      body: _buildListView(mapEntities),
      persistentFooterButtons: [
        if (_isSelectionMode)
          ElevatedButton(
            onPressed: () async => await _exportEntities(mapEntities),
            child: Text('Export ${T}s'),
          ),
        ElevatedButton(
          onPressed: () async => await widget.entityService.addDummy(),
          statesController: WidgetStatesController(),
          child: Text('Add dummy $T'),
        ),
        ElevatedButton(onPressed: () async => await _importEntities(), child: Text('Import ${T}s')),
      ],
    );
  }

  Future<void> _importEntities() async {
    final importedCount = await widget.entityService.importEntities();
    if (importedCount == 0) return;
    Fluttertoast.showToast(msg: "$importedCount ${T}s are successfully imported");
  }

  Future<void> _exportEntities(List<MapEntity> mapEntities) async {
    final selectedDir = await widget.entityService.exportEntities(selectedEntites);
    if (selectedDir == null) return;
    Fluttertoast.showToast(
      msg: "${selectedEntites.length} ${T}s are successfully exported to $selectedDir",
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
        ? Center(child: Text('No ${T}s found'))
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
                subtitle: Text("Created ${mapEntity.createdAt.toDate().toString()}"),
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
                title: const Text("Confirm Deletion"),
                content: Text(
                  count != null
                      ? "Are you sure you want to delete $count selected ${T}s?"
                      : "Are you sure you want to delete '$itemName'?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Delete"),
                  ),
                ],
              ),
        ) ??
        false;
  }

  Future<void> _removeEntity(MapEntity mapEntity) async {
    await widget.entityService.removeEntity(mapEntity);
    Fluttertoast.showToast(msg: "$T '${mapEntity.title}' was successfully deleted");
  }

  Future<void> _removeEntities(BuildContext context) async {
    final confirm = await _showConfirmDeleteDialog(context, count: _selectedIds.length);
    if (confirm) {
      final removeEntitiesCount = selectedEntites.length;
      await widget.entityService.removeEntities(selectedEntites);
      Fluttertoast.showToast(msg: "$removeEntitiesCount $T were successfully deleted");
      _clearSelection();
    }
  }
}
