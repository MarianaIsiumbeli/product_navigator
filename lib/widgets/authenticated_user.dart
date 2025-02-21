import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../pages/profile_page.dart';

class UserAuthWidget extends StatelessWidget {
  const UserAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appState.user?.displayName ?? appState.user?.email ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onSelected: (value) {
              if (value == 'signOut') {
                _showSignOutDialog(context, appState);
              } else if (value == 'updateProfile') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileUpdatePage(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'signOut',
                  child: Text('Sign Out'),
                ),
                const PopupMenuItem<String>(
                  value: 'updateProfile',
                  child: Text('Update Profile'),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () {
                 appState.signOut();        
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
