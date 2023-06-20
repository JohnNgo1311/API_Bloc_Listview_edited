import 'dart:convert';
import "package:bloc_demo/UserRepository.dart";
import "package:bloc/bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:bloc_demo/Model/User_Model.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_event.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_state.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_bloc.dart';

//Class Display DetailScreen
class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.e}) : super(key: key);
  final UserModel e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 42, 244, 197),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 160, 183),
          title: Padding(
            padding: const EdgeInsets.only(left: 55),
            child: Text(
              "Detail User Data",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 28, 160, 183),
                          borderRadius: BorderRadiusDirectional.circular(20)),
                      child: Icon(
                        Icons.people_sharp,
                        size: 30,
                      )),
                ),
                Text(
                  "User id: ${e.id}",
                  style: TextStyle(fontSize: 20),
                ),
                Text("name: ${e.name}", style: TextStyle(fontSize: 20)),
                Text("Age: ${e.age}", style: TextStyle(fontSize: 20)),
                Text('Job: ${e.job}', style: TextStyle(fontSize: 20)),
                Text('Phone: ${e.phoneNumber}', style: TextStyle(fontSize: 20)),
                Text('Email: ${e.email}', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ));
  }
}
