import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../user.dart';
import '../ThemeManager.dart';

class Switches extends StatefulWidget {
  Switches({super.key});

  @override
  State<Switches> createState() => _SwitchesState();
}

class _SwitchesState extends State<Switches> {
  @override
  Widget build(BuildContext context) {
    final User cUser = Provider.of<User>(context);
    ThemeManager themeManager = Provider.of<ThemeManager>(context);

    return AbsorbPointer(
      absorbing: false,
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Notifications',
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            leading: const Icon(Icons.notifications_outlined),
            trailing: Switch(
              //activeColor: Keys.tertiaryColor,
              value: cUser.notify,
              onChanged: (m) {
                cUser.setNotify(m);
              },
            ),
            //    trailing: Switch(activeThumbImage: ImageProvider<const Icon(Icons.delete_sweep)>(),),
          ),
          ListTile(
            title: const Text(
              'Dark Mode',
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            leading: const Icon(Icons.dark_mode_outlined),
            trailing: Switch(
              value: cUser.darkMode,
              onChanged: (m) {
                setState(() {
                  cUser.setDarkMode(m);
                  themeManager.toggleTheme(m);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
