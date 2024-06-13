import 'package:chatt/ui/pages/home_page.dart';
import 'package:chatt/ui/pages/chat.dart';
import 'package:chatt/ui/widgets/pubmed.dart';
import 'package:flutter/material.dart';

import '../../models/services/api_service.dart';

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
    const Text("Page 4", style: TextStyle(fontSize: 30)),
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

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "To Do"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
        body: Container(child: listWidget.elementAt(_selectedIndex)));
  }
}
