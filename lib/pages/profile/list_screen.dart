import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListScreen<T> extends ConsumerWidget {
  final String title;
  final ProviderListenable<List<T>> provider;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(T)? onDelete;

  const ListScreen({
    super.key,
    required this.title,
    required this.provider,
    required this.itemBuilder,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: ValueKey(item),
            // assuming each T has overridden == and hashCode
            direction: onDelete != null ? DismissDirection.endToStart : DismissDirection.none,
            onDismissed: (_) => onDelete?.call(item),
            background: const ColoredBox(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: Card(child: itemBuilder(context, item)),
          );
        },
      ),
    );
  }
}
