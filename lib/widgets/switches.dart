import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys.dart';
import '../user.dart';

class Switches extends StatefulWidget {
  const Switches({super.key});

  @override
  State<Switches> createState() => _SwitchesState();
}

class _SwitchesState extends State<Switches> {
  @override
  Widget build(BuildContext context) {
    final User cUser = Provider.of<User>(context);
    return AbsorbPointer(
      absorbing: true,
      child: Column(
        children: [
          ListTile(
              title: const Text('Notifications',
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.white)),
              leading:
                  const Icon(Icons.notifications_outlined, color: Colors.white),
              trailing: Switch(
                activeColor: Keys.tertiaryColor,
                value: cUser.notify,
                onChanged: (m) {
                  cUser.setNotify(m);
                },
              ),
              //    trailing: Switch(activeThumbImage: ImageProvider<const Icon(Icons.delete_sweep)>(),),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              title: const Text('Dark Mode',
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.white)),
              leading:
                  const Icon(Icons.dark_mode_outlined, color: Colors.white),
              trailing: Switch(
                activeColor: Keys.tertiaryColor,
                value: cUser.darkMode,
                onChanged: (m) {
                  cUser.setDarkMode(m);
                },
              ),
              onTap: () {})
        ],
      ),
    );
  }
}
