import "package:bloc_demo/UserRepository.dart";
import 'package:bloc_demo/login_screen.dart';
import 'package:bloc_demo/shopping_page/shopping_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_event.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_state.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_bloc.dart';
import 'package:bloc_demo/detail_screen.dart';

//Class Home
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
          backgroundColor: const Color.fromARGB(255, 42, 244, 197),
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            elevation: 0,
            title: Container(
              margin: EdgeInsets.only(left: appsize.width * 0.18),
              child: const Text(
                'User Data List',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 28, 160, 183),
          ),
          body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            return Container(
              margin: const EdgeInsets.all(8),
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
                              });
                        }

                        if (state is UserErrorState) {
                          return const Center(child: Text("Error"));
                        }

                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 28, 160, 183)),
                label: 'Back',
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
}
