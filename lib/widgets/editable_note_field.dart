import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/providers/app_user.dart';

class EditableNoteField extends ConsumerStatefulWidget {
  final Note initialNote;

  const EditableNoteField(this.initialNote, {super.key});

  @override
  ConsumerState<EditableNoteField> createState() => _EditableNoteFieldState();
}

class _EditableNoteFieldState extends ConsumerState<EditableNoteField> {
  late TextEditingController _controller;
  String _lastSavedNote = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNote.text);
    _lastSavedNote = widget.initialNote.text;
  }

  void _submitNote() {
    if (_controller.text != _lastSavedNote) {
      ref.read(appUserProvider.notifier).setNote(widget.initialNote.copyWith(text: _controller.text));
      _lastSavedNote = _controller.text;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vlastní poznámky:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            minLines: 3,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Sem napište své poznámky...',
              isDense: true,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _submitNote,
              child: const Text('Uložit'),
            ),
          ),
        ],
      ),
    );
  }
}
