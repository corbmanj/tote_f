import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_additional.dart';
import 'package:tote_f/models/tote/additional_item.dart';
import 'package:tote_f/models/tote/additional_item_section.dart';

class AdditionalCheckboxItem extends ConsumerWidget {
  final AdditionalItem item;
  final AdditionalItemSection section;
  const AdditionalCheckboxItem({super.key, required this.item, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final additionalItemsNotifier = ref.read(updateAdditionalProvider.notifier);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
            value: item.isPacked ?? false,
            onChanged: (bool? val) =>
                additionalItemsNotifier.packAdditionalItem(item, section, val ?? false)),
        GestureDetector(
          child: Text(item.name),
          onTap: () =>
              additionalItemsNotifier.packAdditionalItem(item, section, !item.isPacked!),
        ),
      ],
    );
  }
}
