import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/tote/additional_item.dart';
import 'package:tote_f/models/tote/additional_item_section.dart';
import 'package:tote_f/pages/packing_list/additional_checkbox_item.dart';

class AdditionalItemsToPack extends ConsumerWidget {
  final List<AdditionalItemSection> additionalItems;
  const AdditionalItemsToPack({super.key, required this.additionalItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: additionalItems
            .map((AdditionalItemSection section) => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      '${section.name}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...section.items
                        .where((AdditionalItem item) => item.included == true)
                        .map((AdditionalItem item) => AdditionalCheckboxItem(
                            item: item, section: section)),
                  ],
                ))
            .toList());
  }
}
