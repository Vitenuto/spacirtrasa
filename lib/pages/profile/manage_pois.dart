import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/poi.dart';
import 'package:spacirtrasa/providers/poi.dart';

import '../../services/poi_service.dart';

class ManagePois extends ConsumerStatefulWidget {
  const ManagePois({super.key});

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
    final pois = ref.watch(poiProvider);

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
                _selectedIds.length == pois.length ? Icons.select_all_outlined : Icons.done_all,
              ),
              tooltip: _selectedIds.length == pois.length ? 'Deselect All' : 'Select All',
              onPressed: () => _selectAll(pois),
            ),
          if (_isSelectionMode)
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete Selected',
              onPressed: () async {
                final confirm = await _showConfirmDeleteDialog(context, count: _selectedIds.length);
                if (confirm) {
                  for (var id in _selectedIds) {
                    PoiService.removePoi(id);
                  }
                  _clearSelection();
                }
              },
            ),
        ],
      ),
      body: _buildListView(pois),
      persistentFooterButtons: [
        if (_isSelectionMode) ElevatedButton(
          onPressed: () => _exportPoiClicked(pois),
          child: const Text('Export POIs'),
        ),
        ElevatedButton(onPressed: () => _addDummyPoi(), child: const Text('Add dummy POI')),
        ElevatedButton(onPressed: () => PoiService.importPois(), child: const Text('Import POIs')),
      ],
    );
  }

  void _exportPoiClicked(List<Poi> pois) {
    final selectedPois = pois.where((poi) => _selectedIds.contains(poi.id)).toList();
    PoiService.exportPois(selectedPois);
    _clearSelection();
  }

  void _clearSelection() {
    setState(() {
      _isSelectionMode = false;
      _selectedIds.clear();
    });
  }

  void _selectAll(List<Poi> pois) {
    setState(() {
      final allSelected = _selectedIds.length == pois.length;
      if (allSelected) {
        _selectedIds.clear();
      } else {
        _selectedIds.addAll(pois.map((e) => e.id));
      }
    });
  }

  Widget _buildListView(List<Poi> pois) {
    return pois.isEmpty
        ? const Center(child: Text('No POIs found'))
        : ListView.builder(
      itemCount: pois.length,
      itemBuilder: (context, index) {
        final poi = pois[index];
        final isSelected = _selectedIds.contains(poi.id);

        return Dismissible(
          key: Key(poi.id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: _isSelectionMode ? DismissDirection.none : DismissDirection.startToEnd,
          confirmDismiss: (_) async {
            return await _showConfirmDeleteDialog(context, itemName: poi.title);
          },
          onDismissed: (_) async => await PoiService.removePoi(poi.id),
          child: ListTile(
            title: Text(poi.title),
            subtitle: Text("Created ${poi.creationDate.toDate().toString()}"),
            trailing:
            _isSelectionMode
                ? Checkbox(value: isSelected, onChanged: (_) => _toggleSelection(poi.id))
                : null,
            onLongPress: () {
              _toggleSelection(poi.id);
            },
            onTap: _isSelectionMode ? () => _toggleSelection(poi.id) : null,
          ),
        );
      },
    );
  }

  Future<bool> _showConfirmDeleteDialog(BuildContext context, {
    int? count,
    String? itemName,
  }) async {
    return await showDialog<bool>(
      context: context,
      builder:
          (context) =>
          AlertDialog(
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

  Future<void> _addDummyPoi() async {
    final newPoi = Poi(
      id: 'WillBeReplacedByUniqueOneAutomatically',
      title: 'DummyPoi',
      imgUrl: 'https://www.orechovubrna.cz/data/kategorie/545_658_galerie.jpg',
      creationDate: Timestamp.now(),
      flags: {PoiFlags.monument, PoiFlags.food, PoiFlags.nature, PoiFlags.transportation},
      location: GeoPoint(49.1118439, 16.5184100),
      markdownData: """## Kaple sv. Peregrina
    ![Kaplicka](https://www.orechovubrna.cz/data/kategorie/545_658_galerie.jpg)
    Kaple se nachází na kopci mezi obcemi Ořechov, Nebovidy a Želešice. Místo, kde kaple stojí, sehrálo důležitou úlohu při měření tzv. vídeňského poledníku v roce 1759, kdy byla jedním z pomocných trigonometrických bodů (smyslem měření bylo určení tvaru a velikosti Země). V roce 1863 zde byla vybudována zděná kaple, zasvěcená sv. Peregrinovi a váže se k ní stoletá tradice pěších poutí z Brna a okolí do Mariazell. Kaple byla první zastávkou na cestě, kde poutníci před obrazem Matky Boží a sv. Peregrina prosili o Boží pomoc a šťastný návrat domů.

    Tradice poutí je stále živá. Poutě byly v historii přerušeny v době válek a také v době komunistické vlády. Ale i tehdy se poutníci potají scházeli nadále, aby se u kapličky alespoň pomodlili.

    Každým rokem v květnu se koná pěší pouť ke kapličce, kde se farníci z blízkého okolí schází ke společné bohoslužbě. Je to jediná pouť ke cti sv. Peregrina, patrona při bolestech nohou a nemocech rakoviny, která se v naší zemi koná pravidelně.

        Ke kapli však zavítají poutníci i během celého roku, svědčí o tom vzkazy a svěřené úmysly modliteb, srdečné pozdravy a zapálené svíčky.
        """,
    );

    await PoiService.persistPoi(newPoi);
  }
}
