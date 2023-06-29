import 'package:bloc_demo/Login_screen.dart';
import 'package:bloc_demo/login/bloc/login_bloc.dart';
import 'package:bloc_demo/user_list.dart';
import 'UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

// Maindart
void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RepositoryProvider(
          create: (context) => UserRepository(),
          child: BlocProvider(
            create: (context) =>
                LoginBloc(RepositoryProvider.of<UserRepository>(context)),
            child: const LoginScreen(),
          ),
        ));
  }
}
