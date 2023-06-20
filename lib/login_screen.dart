import 'dart:convert';
import "package:bloc_demo/UserRepository.dart";
import "package:bloc/bloc.dart";
import 'package:bloc_demo/home_page.dart';
import 'package:bloc_demo/login/bloc/login_bloc.dart';
import 'package:bloc_demo/login/bloc/login_event.dart';
import 'package:bloc_demo/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:bloc_demo/choose_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Text controller
  final _accountCtroller = TextEditingController();
  final _passCtroller = TextEditingController();

  String username = "";
  String password = "";

  bool _isObscure = true;
// APP
  @override
  Widget build(BuildContext context) {
    Size appsize = MediaQuery.of(context).size;

    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoaded && state.check == true) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => choosePage()));
            }
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, appsize.height * 0.1, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Center(
                        child: FlutterLogo(
                          size: 65,
                        ),
                      )),

                  // Hi and WELCOME BACK FIELD
                  Text(
                    'Hi!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 28, 160, 183),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Welcome Back!!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //"username field"
                  TextField(
                      onChanged: (newUsername) {
                        print(newUsername);
                        username = newUsername;
                      },
                      controller: _accountCtroller,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 135, 129, 126)))),

                  // "password" field
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        TextField(
                          onChanged: (newPassword) {
                            print(newPassword);
                            password = newPassword;
                          },
                          controller: _passCtroller,
                          obscureText: _isObscure,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 155, 153, 152)),
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // sign in field
                  SizedBox(
                      width: double.infinity,
                      height: (50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 28, 160, 183),
                        ),
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginButtonPressed(
                                  password: _passCtroller.text,
                                  username: _accountCtroller.text));
                        },
                        child: Text("Sign in",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      )),

                  //sign up and forget password field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "sign up.",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 158, 158, 158),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget password?",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 158, 158, 158),
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
