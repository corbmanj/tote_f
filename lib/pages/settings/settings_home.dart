import 'package:flutter/material.dart';
import 'package:tote_f/pages/settings/settings_additional_items.dart';
import 'package:tote_f/pages/settings/settings_items.dart';
import 'package:tote_f/pages/settings/settings_outfits.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({super.key});

  void onItems(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: ((context) => const SettingsItemsTabView())),
    );
  }

  void onOutfits(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: ((context) => const SettingsOutfits())),
    );
  }

  void onAdditional(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: ((context) => const SettingsAdditionalItems())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _buildNavTile(
            title: 'Items',
            icon: Icons.inventory_2_outlined,
            onTap: () => onItems(context),
          ),
          _buildNavTile(
            title: 'Outfits',
            icon: Icons.checkroom_outlined,
            onTap: () => onOutfits(context),
          ),
          _buildNavTile(
            title: 'Additional Items',
            icon: Icons.list_alt_outlined,
            onTap: () => onAdditional(context),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile({
    required String title,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
