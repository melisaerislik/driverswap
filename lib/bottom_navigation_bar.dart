import 'package:driver_swap/pages/Anasayfa.dart';
import 'package:driver_swap/pages/ChatScreen.dart';
import 'package:driver_swap/pages/ConversationScreen.dart';
import 'package:driver_swap/pages/ProfilSayfasi.dart';
import 'package:flutter/material.dart';

class EditBottomNavigationBar extends StatefulWidget {
  EditBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<EditBottomNavigationBar> createState() =>
      _EditBottomNavigationBarState();
}

class _EditBottomNavigationBarState extends State<EditBottomNavigationBar> {
  int _secilenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _secilenIndex = index;
            });
          },
          backgroundColor: Colors.yellow[100],
          indicatorColor: Colors.yellow[200],
          selectedIndex: _secilenIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Ana Sayfa',
            ),
            NavigationDestination(
              icon: Icon(Icons.message_sharp),
              label: 'Görüşmeler',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
        body: <Widget>[
          Anasayfa(),
          ConversationsScreen(),
          ProfilSayfasi(),
        ][_secilenIndex],
      ),
    );
  }
}
