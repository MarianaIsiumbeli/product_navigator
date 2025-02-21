import 'package:flutter/material.dart';
import 'package:product_navigator/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../widgets/authenticated_user.dart';

// this class represents the Settings page where users can toggle between dark and light modes
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // access the AppState to get and update the theme
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
          actions: const [
          UserAuthWidget(),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: appState.isDarkMode,
              activeColor: Colors.lightBlue,
              activeTrackColor: Colors.lightBlueAccent,
              onChanged: (value) {
                //call method to switch between light and dark mod
                appState.toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}