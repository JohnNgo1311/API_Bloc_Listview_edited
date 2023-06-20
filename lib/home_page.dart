import 'dart:convert';
import "package:bloc_demo/UserRepository.dart";
import "package:bloc/bloc.dart";
import 'package:bloc_demo/choose_page.dart';
import 'package:bloc_demo/login_screen.dart';
import 'package:bloc_demo/shopping_page/shopping_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:bloc_demo/Model/User_Model.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_event.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_state.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_bloc.dart';
import 'package:bloc_demo/detail_screen.dart';

//Class Home
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TextEditingController filterKeyword = TextEditingController(text: "");
    Size appsize = MediaQuery.of(context).size;
    bool visible = true;
    return BlocProvider(
        create: (context) => UserBloc(
              RepositoryProvider.of<UserRepository>(context),
            )..add(LoadUserEvent()),
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 42, 244, 197),
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => choosePage(),
                      ));
                }),
            elevation: 0,
            title: Container(
              margin: EdgeInsets.only(left: appsize.width * 0.18),
              child: const Text(
                'User Data List',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 28, 160, 183),
          ),
          body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            return Container(
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: filterKeyword,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        hintText: "Eg: Johny",
                        hintStyle: TextStyle(color: Colors.black54),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.black,
                            iconSize: 25,
                            onPressed: () {
                              BlocProvider.of<UserBloc>(context)
                                  .add(FilterUserEvent(
                                searchText: filterKeyword.text,
                              ));
                            })),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (state is UserLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is UserLoadedState) {
                          return ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (BuildContext, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          e: state.users[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: Color.fromARGB(255, 28, 160, 183),
                                    child: ListTile(
                                      leading: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Icon(Icons.people)),
                                      title: Text(
                                        state.users[index].name.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                          state.users[index].email.toString(),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ),
                                );
                              });
                        }

                        if (state is UserErrorState) {
                          return Center(child: Text("Error"));
                        }

                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
