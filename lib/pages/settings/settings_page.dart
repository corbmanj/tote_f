import 'package:flutter/material.dart';
import 'package:tote_f/pages/settings/settings_additional_items.dart';
import 'package:tote_f/pages/settings/settings_outfits.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(text: 'Outfits'),
            Tab(text: 'Additional Items'),
          ]),
          title: const Text('Settings'),
        ),
        body: const TabBarView(children: [
          SettingsOutfits(),
          SettingsAdditionalItems(),
        ]),
      ),
    );
  }
}
