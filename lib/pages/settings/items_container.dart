import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/pages/settings/delete_items_box.dart';
import 'package:tote_f/pages/settings/item_draggable_chip.dart';
import 'package:tote_f/providers/user_items_provider.dart';

class ItemsContainer extends ConsumerWidget {
  const ItemsContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userItems = ref.watch(userItemsProvider);
    return switch (userItems) {
      AsyncData(:final value) => NewBox(items: value.userItems),
      AsyncError(:final error) => Text(error.toString()),
      _ => SizedBox(
          width: 50.0,
          height: 50.0,
          child: CircularProgressIndicator(),
        )
    };
  }
}

class NewBox extends StatelessWidget {
  final List<ItemTemplate> items;
  const NewBox({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 2.0)),
                child: Center(child: Text("All Items")),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.black12,
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: [
                    ...items.map((item) => ItemDraggableChip(item: item)),
                    AddChip()
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        DeleteItemsBox(),
      ],
    );
  }
}

class AddChip extends ConsumerWidget {
  const AddChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(userItemsProvider.notifier);
    return GestureDetector(
        onTap: () => notifier.addUserItem('new type'),
        child: Chip(
            label: Icon(
          Icons.add,
          size: 18.0,
        )));
  }
}
