import 'dart:convert';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_event.dart';
import 'package:flutter/material.dart';
import 'package:bloc_demo/Model/User_Model.dart';
import 'package:bloc_demo/login_screen.dart';
import 'package:bloc_demo/shopping_page/shopping_page.dart';
import 'package:bloc_demo/choose_page.dart';
import 'package:http/http.dart' as http;
import 'User_getAPI/bloc/user_get_api_bloc.dart';
import 'edit_users.dart';

//Class Display DetailScreen
class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.e, required this.userBloc})
      : super(key: key);
  final UserModel e;
  final UserBloc userBloc;

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
              icon:
                  Icon(Icons.people, color: Color.fromARGB(255, 28, 160, 183)),
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
                    icon: const Icon(Icons.edit_calendar_rounded),
                    color: const Color.fromARGB(255, 28, 160, 183),
                    onPressed: () {
                      var userId = e.id.toString();

                      var userJob = e.job.toString();

                      var userName = e.name.toString();

                      var userEmail = e.email.toString();

                      var userAge = e.age.toString();

                      var userPhoneNumber = e.phoneNumber.toString();
                      Navigator.push(
                          context as BuildContext,
                          MaterialPageRoute(
                            builder: (context) => EditUser(
                                userAge: userAge,
                                userEmail: userEmail,
                                userId: userId,
                                userJob: userJob,
                                userName: userName,
                                userPhoneNumber: userPhoneNumber),
                          ));
                    }),
                label: 'Edit',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
              icon: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Color.fromRGBO(28, 160, 183, 1),
                  onPressed: () async {
                    var idForDelete = e.id;
                    print(idForDelete);
                    await deleteUser(idForDelete = e.id);
                    Navigator.pop(context);
                    userBloc.add(LoadUserEvent());
                  }),
              label: 'Delete',
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

  Future deleteUser(int? idForDelete) async {
    final uri = Uri.parse("https://retoolapi.dev/aMsZrK/data/${idForDelete}");
    print(uri);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      print(response.statusCode);
      final result = jsonDecode(response.body);
      print("Delete Successfully");
      return result;
    } else
      () {
        var messege = "Can not delete User";
        print(messege);
      };
  }

  // editUser(e) async {
  //   var userId = e.id.toString();

  //   String userJob = e.job;

  //   String userName = e.name;

  //   String userEmail = e.email;

  //   var userAge = e.age.toString();

  //   var userPhoneNumber = e.phoneNumber.toString();
  //   Navigator.push(
  //       context as BuildContext,
  //       MaterialPageRoute(
  //         builder: (context) => EditUser(
  //             userAge: userAge,
  //             userEmail: userEmail,
  //             userId: userId,
  //             userJob: userJob,
  //             userName: userName,
  //             userPhoneNumber: userPhoneNumber),
  //       ));
  // }
}
