import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/models/tote/outfit.dart';
import 'package:tote_f/models/user/outfit_item.dart';
import 'package:tote_f/providers/named_items_provider.dart';

class NamedItemsForOutfit extends ConsumerWidget {
  final Outfit outfit;
  const NamedItemsForOutfit({super.key, required this.outfit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Named> namedItemsRef = ref.watch(namedItemsNotifierProvider);
    final List<Named> namedList = outfit.items
        .where((item) => item.namedItemId != null)
        .map((OutfitItem item) => namedItemsRef.firstWhere((named) => named.ordering == item.namedItemId))
        .toList();
    return (Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: namedList
            .map((Named namedItem) => Chip(
                  label: Text(namedItem.name),
                  padding: const EdgeInsets.all(1.0),
                  visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                  color: const MaterialStatePropertyAll(Colors.blue)
                ))
            .toList()));
  }
}
