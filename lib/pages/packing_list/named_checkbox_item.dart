import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_named.dart';
import 'package:tote_f/models/tote/named.dart';

class NamedCheckboxItem extends ConsumerWidget {
  final Named item;
  const NamedCheckboxItem({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namedItemsNotifier = ref.read(updateNamedProvider.notifier);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
            value: item.isPacked,
            onChanged: (bool? val) =>
                namedItemsNotifier.packNamedItem(item, !item.isPacked)),
        GestureDetector(
          child: Text(item.name),
          onTap: () =>
              namedItemsNotifier.packNamedItem(item, !item.isPacked),
        ),
      ],
    );
  }
}
