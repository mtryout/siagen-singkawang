import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:singkawang/screens/auth/login.dart';
import 'package:singkawang/screens/mainmenu/news.dart';
import 'home.dart';
import 'agenda.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectItemIndex = 0;
  final List pages = [
    const HomeScreen(),
    null,
    const AgendaScreen(),
    const NewsScreen(),
    const LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF0F0F0),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
          currentIndex: _selectItemIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _selectItemIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Beranda",
              icon: Icon(AntDesign.home),
              
            ),
            BottomNavigationBarItem(
              label: "Obrolan",
              icon: Icon(AntDesign.message1),
              
            ),
            BottomNavigationBarItem(
              label: "Agenda",
              icon: Icon(AntDesign.calendar),
              
            ),            BottomNavigationBarItem(
              label: "Berita",
              icon: Icon(AntDesign.inbox),
              
            ),
            BottomNavigationBarItem(
              label: "Akun",
              icon: Icon(AntDesign.user),
              
            ),
          ],
        ),
        body: pages[_selectItemIndex],
      ),
    );
  }
}