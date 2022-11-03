import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/cart_Page.dart';
import 'package:miniproject_1/drawer.dart';
import 'package:miniproject_1/home_Page.dart';
import 'package:miniproject_1/profile_page.dart';
import 'package:miniproject_1/reviewPage.dart';


class BottomNavi extends StatefulWidget {
  const BottomNavi({Key? key}) : super(key: key);
  @override
  _BottomNaviState createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  final auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Cart(),
    ReviewPage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SharedDrawer(),
      appBar: AppBar(
        title: const Center(
          child: Text('Sodsai Shop',
                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30,
                            fontFamily: 'Mitr'
                          ),
                        ),
        ),
        backgroundColor:  Color.fromARGB(255, 245, 	173,172 ),
        actions: <Widget>[
            IconButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: const Icon(Icons.logout))
          ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 245, 	173,172 ),
        selectedFontSize: 20,
        unselectedFontSize: 15,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Color.fromARGB(255, 216,78,78)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note_alt_outlined),
              label: 'Review',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle),
              label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 216,78,78),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}



