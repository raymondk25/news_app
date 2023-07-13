import 'package:flutter/material.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      "assets/images/newspaper.png",
                      height: 60,
                      width: 60,
                    ),
                  ),
                  const VerticalSpacing(20),
                  const Text("News App"),
                ],
              ),
            ),
            const VerticalSpacing(20),
            ListTiles(
              label: "Home",
              icon: themeProvider.getDarkTheme ? IconlyBold.home : IconlyLight.home,
              function: () {},
            ),
            ListTiles(
              label: "Bookmark",
              icon: themeProvider.getDarkTheme ? IconlyBold.bookmark : IconlyLight.bookmark,
              function: () {},
            ),
            const Divider(thickness: 5),
            SwitchListTile(
                title: Text(
                  themeProvider.getDarkTheme ? 'Dark' : 'Light',
                  style: const TextStyle(fontSize: 20),
                ),
                secondary: Icon(
                  themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                value: themeProvider.getDarkTheme,
                onChanged: (bool value) {
                  setState(() {
                    themeProvider.setDarkTheme = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}

class ListTiles extends StatelessWidget {
  const ListTiles({
    Key? key,
    required this.label,
    required this.icon,
    required this.function,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
      onTap: () {
        function();
      },
    );
  }
}
