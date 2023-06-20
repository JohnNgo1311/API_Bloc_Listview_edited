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

// Maindart
void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) =>
            LoginBloc(RepositoryProvider.of<UserRepository>(context)),
        child: LoginScreen(),
      ),
    ));
  }
}
