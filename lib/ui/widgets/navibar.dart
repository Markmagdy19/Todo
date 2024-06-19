import 'package:chatt/ui/pages/chat.dart';
import 'package:chatt/ui/pages/home_page.dart';
import 'package:chatt/ui/pages/pubmed.dart';
import 'package:chatt/ui/pages/settings_page.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class Navigatebar extends StatefulWidget {
  const Navigatebar({super.key});

  @override
  _NavigatebarState createState() => _NavigatebarState();
}

int _selectedIndex = 0;

class _NavigatebarState extends State<Navigatebar> {
  final List<Widget> listWidget = [
    ArticleListScreen(),
    const HomePage(),
    const ChatScreen(),
    SettingsPageUI(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (val) {
            setState(() {
              _selectedIndex = val;
            });
          },
          currentIndex: _selectedIndex,
          //backgroundColor: Colors.blueAccent,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          //selectedFontSize: 20,
          //unselectedFontSize: 14,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: S.of(context).home),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit), label: S.of(context).todo),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat), label: S.of(context).chat),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: S.of(context).settings),
          ],
        ),
        body: Container(child: listWidget.elementAt(_selectedIndex)));
  }
}
