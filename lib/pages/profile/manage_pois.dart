import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/providers/poi.dart';

import '../../models/map_entity.dart';
import '../../services/map_entity/map_entity_service.dart';

class ManagePois extends ConsumerStatefulWidget {
  final MapEntityService entityService;

  const ManagePois(this.entityService, {super.key});

  @override
  ConsumerState<ManagePois> createState() => _ManagePoisState();
}

class _ManagePoisState extends ConsumerState<ManagePois> {
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

  @override
  Widget build(BuildContext context) {
    final mapEntities = ref.watch(poiProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode ? '${_selectedIds.length} selected' : 'Manage POIs'),
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
              onPressed: () async {
                final confirm = await _showConfirmDeleteDialog(context, count: _selectedIds.length);
                if (confirm) {
                  final entitiesToRemove = mapEntities.where((entity) => _selectedIds.contains(entity.id));
                  widget.entityService.removeEntities(entitiesToRemove);
                  _clearSelection();
                }
              },
            ),
        ],
      ),
      body: _buildListView(mapEntities),
      persistentFooterButtons: [
        if (_isSelectionMode)
          ElevatedButton(
            onPressed: () => _exportPoiClicked(mapEntities),
            child: const Text('Export POIs'),
          ),
        ElevatedButton(onPressed: () => widget.entityService.addDummy(), child: const Text('Add dummy POI')),
        ElevatedButton(onPressed: () => widget.entityService.importEntities(), child: const Text('Import POIs')),
      ],
    );
  }

  void _exportPoiClicked(List<MapEntity> mapEntities) {
    final selectedEntites =
        mapEntities.where((mapEntity) => _selectedIds.contains(mapEntity.id)).toList();
    widget.entityService.exportEntities(selectedEntites);
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
        ? const Center(child: Text('No POIs found'))
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
              onDismissed: (_) async => await widget.entityService.removeEntity(mapEntity),
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
                onLongPress: () {
                  _toggleSelection(mapEntity.id);
                },
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
                      ? "Are you sure you want to delete $count selected POIs?"
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
}
