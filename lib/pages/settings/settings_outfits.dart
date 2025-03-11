import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/pages/settings/items_container.dart';
import 'package:tote_f/pages/settings/outfit_container.dart';
import 'package:tote_f/providers/user_outfits_provider.dart';

class SettingsOutfits extends ConsumerWidget {
  const SettingsOutfits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outfitsList = ref.watch(userOutfitsProvider);
    final outfitsNotifier = ref.read(userOutfitsProvider.notifier);

    return switch (outfitsList) {
      AsyncData(value: final outfits) => Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ItemsContainer(),
                )
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int outfitIndex) {
                      if (outfitIndex == outfits.length) {
                        return ElevatedButton(onPressed: () {
                          outfitsNotifier.addOutfit();
                        }, child: Text("Add Outfit"));
                      }
                        return OutfitContainer(outfit: outfits[outfitIndex]);
                    },
                    separatorBuilder: (BuildContext context, int outfitIndex) =>
                        SizedBox(width: 30.0),
                    itemCount: outfits.length + 1),
              ),
            )
          ],
        ),
      _ => CircularProgressIndicator(),
    };
  }
}
