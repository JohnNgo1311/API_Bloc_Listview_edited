import 'package:bloc_demo/user_list.dart';
import 'package:bloc_demo/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc_demo/shopping_page/shopping_page.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});
  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  @override
  Widget build(BuildContext context) {
    Size appsize = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 28, 160, 183),
          elevation: 0,
          leading: IconButton(
              alignment: Alignment.center,
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              }),
          title: Container(
            margin: EdgeInsets.only(left: appsize.width * 0.18),
            child: const Text(
              "Choosing Page",
            ),
          )),
      backgroundColor: const Color.fromARGB(255, 42, 244, 197),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 28, 160, 183)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ShoppingApp();
                    }));
                  },
                  child: const Text(
                    "Go To Shopping Page",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 250,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 28, 160, 183)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserList()));
                    },
                    child: const Text(
                      "Go to ListView Page",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ]),
      ),
    ));
  }
}
