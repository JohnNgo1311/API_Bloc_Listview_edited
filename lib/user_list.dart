import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import "package:bloc_demo/UserRepository.dart";
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_bloc.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_event.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_state.dart';
import 'package:bloc_demo/choose_page.dart';
import 'package:bloc_demo/detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:bloc_demo/login_screen.dart';
import 'package:bloc_demo/shopping_page/shopping_page.dart';

import 'Model/User_Model.dart';

//Class Home
class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController filterKeyword = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerJob = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserBloc(
              RepositoryProvider.of<UserRepository>(context),
            )..add(LoadUserEvent()),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 42, 244, 197),
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            elevation: 0,
            actions: [
              TextButton(
                child: const Text('Add User',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                onPressed: () => addUser(context),
              )
            ],
            centerTitle: true,
            title: const Text(
              'User Data List',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 28, 160, 183),
          ),
          body: Container(
            margin: const EdgeInsets.all(8),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              TextField(
                controller: filterKeyword,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    hintText: "Eg: Johny",
                    hintStyle: const TextStyle(color: Colors.black54),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        color: Colors.black,
                        iconSize: 25,
                        onPressed: () {
                          BlocProvider.of<UserBloc>(context)
                              .add(FilterUserEvent(
                            searchText: filterKeyword.text,
                          ));
                        })),
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is UserLoadedState) {
                    if (state.users.isEmpty) {
                      return const Center(
                        child: Text('Empty'),
                      );
                    }
                  }
                  if (state is UserErrorState) {
                    return const Center(child: Text("Error"));
                  }

                  return Expanded(child: Builder(builder: (context) {
                    if (state is UserLoadedState) {
                      if (state.users.isEmpty) {
                        return const CircularProgressIndicator();
                      } else {
                        return SmartRefresher(
                          controller: _refreshController,
                          onRefresh: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 1000));
                            _refreshController.refreshCompleted();
                            BlocProvider.of<UserBloc>(context)
                                .add(LoadUserEvent());
                          },
                          child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (c) => DetailScreen(
                                            e: state.users[index],
                                            userBloc: BlocProvider.of<UserBloc>(
                                                context)),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color:
                                        const Color.fromARGB(255, 28, 160, 183),
                                    child: ListTile(
                                      leading: const SizedBox(
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
                              }),
                        );
                      }
                    }
                    return Container();
                  }));
                },
              ),
            ]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                    icon: const Icon(Icons.home),
                    color: const Color.fromARGB(255, 28, 160, 183),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChoosePage(),
                          ));
                    }),
                label: 'Home',
                backgroundColor: Colors.white,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.people,
                    color: Color.fromARGB(255, 28, 160, 183)),
                label: 'List View',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  color: const Color.fromARGB(255, 28, 160, 183),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShoppingApp(),
                        ));
                  },
                ),
                label: 'Shopping',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const Icon(Icons.logout,
                      color: Color.fromARGB(255, 28, 160, 183)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  },
                ),
                label: 'Log out',
              ),
            ],
            currentIndex: 1,
            selectedItemColor: Colors.amber[800],
            onTap: null,
          ),
        ));
  }

  Future<dynamic> addUser(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext contex) => AlertDialog(
        title: const Text('Add User'),
        content: SingleChildScrollView(
          child: ListBody(children: [
            TextField(
              controller: _controllerId,
              decoration: const InputDecoration(hintText: "Your Id"),
              onChanged: (value) => print(_controllerId.text),
              cursorColor: const Color.fromARGB(255, 42, 244, 197),
            ),
            const SizedBox(height: 15),
            TextField(
                controller: _controllerAge,
                onChanged: (value) => print(_controllerAge.text),
                decoration: const InputDecoration(hintText: "Your Age"),
                cursorColor: const Color.fromARGB(255, 42, 244, 197)),
            const SizedBox(height: 15),
            TextField(
                controller: _controllerJob,
                onChanged: (value) => print(_controllerJob.text),
                decoration: const InputDecoration(hintText: "Your Job"),
                cursorColor: const Color.fromARGB(255, 42, 244, 197)),
            const SizedBox(height: 15),
            TextField(
                controller: _controllerName,
                decoration: const InputDecoration(hintText: "Your Name"),
                onChanged: (value) => print(_controllerName.text),
                cursorColor: const Color.fromARGB(255, 42, 244, 197)),
            const SizedBox(height: 15),
            TextField(
                controller: _controllerEmail,
                decoration: const InputDecoration(hintText: "Your Email"),
                onChanged: (value) => print(_controllerEmail.text),
                cursorColor: const Color.fromARGB(255, 42, 244, 197)),
            const SizedBox(height: 15),
            TextField(
                controller: _controllerPhoneNumber,
                decoration:
                    const InputDecoration(hintText: "Your Phone Number"),
                onChanged: (value) => print(_controllerPhoneNumber.text),
                cursorColor: const Color.fromARGB(255, 42, 244, 197)),
          ]),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(contex),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Register(
                newId: _controllerId.text,
                newAge: _controllerAge.text,
                newJob: _controllerJob.text,
                newName: _controllerName.text,
                newEmail: _controllerEmail.text,
                newPhone: _controllerPhoneNumber.text,
              );
              Navigator.pop(contex);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

// RE
  Future Register(
      {String? newId,
      String? newAge,
      String? newJob,
      String? newName,
      String? newEmail,
      String? newPhone}) async {
    var url = "https://retoolapi.dev/aMsZrK/data";
    var urlParse = Uri.parse(url);
    int newId = int.parse(_controllerId.text);
    int newAge = int.parse(_controllerAge.text);
    var bodyData = json.encode({
      "id": newId,
      "Age": newAge,
      "Job": newJob,
      "Name": newName,
      "Email": newEmail,
      "PhoneNumber": newPhone,
    });
    final response = await http.post(
      urlParse,
      headers: {
        'Content-Type': 'application/json',
      },
      body: bodyData,
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      final result = jsonDecode(response.body);
      print(result);
      print(const Text("Regist Successfully"));
      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      () {
        print("error");
      };
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UserList(),
        ));
  }
}
