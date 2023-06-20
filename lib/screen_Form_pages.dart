import 'package:bloc_demo/choose_page.dart';
import 'package:bloc_demo/shopping_page/shopping_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bloc_demo/Login_screen.dart';
import 'package:bloc_demo/login/bloc/login_bloc.dart';

import 'UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:bloc_demo/Model/User_Model.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_event.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_state.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_bloc.dart';
import 'package:bloc_demo/detail_screen.dart';
import 'package:bloc_demo/home_page.dart';
import 'package:flutter/services.dart';

class ScreenForm extends StatelessWidget {
  const ScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _ScreenForm(),
    );
  }
}

class _ScreenForm extends StatefulWidget {
  const _ScreenForm({super.key});

  @override
  State<_ScreenForm> createState() => __ScreenFormState();
}

class __ScreenFormState extends State<_ScreenForm> {
  int _selectedIndex = 1;

  List<Widget> _widgetOptions = <Widget>[
    choosePage(),
    Home(),
    ShoppingApp(),
    LoginScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 28, 160, 183)),
            label: 'Back',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, color: Color.fromARGB(255, 28, 160, 183)),
            label: 'List View',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                color: Color.fromARGB(255, 28, 160, 183)),
            label: 'Shopping',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon:
                  Icon(Icons.logout, color: Color.fromARGB(255, 28, 160, 183)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
            ),
            label: 'Log out',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
