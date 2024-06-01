import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignItemsHeader extends StatelessWidget {
  const AssignItemsHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Additional Tote Items'),
    );
  }
}

class AssignAdditionalItems extends ConsumerWidget {
  const AssignAdditionalItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AssignItemsHeader(),
            const Divider(
              thickness: 4,
            ),
            AssignOutfit(dayIndex: index, day: dayRef),
          ],
        ),
      ),
    );
  }
}