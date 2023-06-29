import 'dart:convert';
import 'package:bloc_demo/UserRepository.dart';
import 'package:bloc_demo/login_screen.dart';
import 'package:bloc_demo/user_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "Model/User_Model.dart";
import 'detail_screen.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_bloc.dart';

//Class Home
class EditUser extends StatefulWidget {
  String userId;
  String userName;
  String userJob;
  String userEmail;
  String userPhoneNumber;
  String userAge;
  EditUser(
      {super.key,
      required this.userAge,
      required this.userEmail,
      required this.userId,
      required this.userJob,
      required this.userName,
      required this.userPhoneNumber});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController filterKeyword = new TextEditingController();
  TextEditingController _controllerId = new TextEditingController();
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerJob = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPhoneNumber = new TextEditingController();
  TextEditingController _controllerAge = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _controllerId.text = widget.userId;
      _controllerName.text = widget.userName;
      _controllerJob.text = widget.userJob;
      _controllerAge.text = widget.userAge;
      _controllerEmail.text = widget.userEmail;
      _controllerPhoneNumber.text = widget.userPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 28, 160, 183),
          title: Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Text("Edit User"),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
      body: getbody(),
    );
  }

  getbody() {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: _controllerId,
          decoration: InputDecoration(hintText: "Id:"),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllerAge,
          decoration: InputDecoration(hintText: "Age:"),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllerJob,
          decoration: InputDecoration(hintText: "Job:"),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllerName,
          decoration: InputDecoration(hintText: "Name:"),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllerEmail,
          decoration: InputDecoration(hintText: "Email:"),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controllerPhoneNumber,
          decoration: InputDecoration(hintText: "PhoneNumber:"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            letEdit();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserList(),
                ));
          },
          child: Text(
            "Update",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: Color.fromARGB(255, 28, 160, 183)),
        )
      ],
    );
  }

  Future letEdit() async {
    var editName = _controllerName.text;
    var editEmail = _controllerEmail.text;
    var editJob = _controllerJob.text;
    var editAge = _controllerAge.text;
    var editPhoneNumber = _controllerPhoneNumber.text;
    var editId = _controllerId.text;

    if (editName.isNotEmpty &&
        editEmail.isNotEmpty &&
        editJob.isNotEmpty &&
        editAge.isNotEmpty &&
        editPhoneNumber.isNotEmpty &&
        editId.isNotEmpty) {
      final url =
          Uri.parse("https://retoolapi.dev/aMsZrK/data/${_controllerId.text}");
      print(url);
      int editAge = int.parse(_controllerAge.text);
      int editId = int.parse(_controllerId.text);
      var bodyData = json.encode({
        "id": editId,
        "Age": editAge,
        "Job": editJob,
        "Name": editName,
        "Email": editEmail,
        "PhoneNumber": editPhoneNumber
      });
      var response = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 200) {
        print(response.statusCode);
        final result = json.decode(response.body);
        print("update successfully");
        return result;
      } else {
        var messageError = "Can not update this user!!";
        print(messageError);
      }
    }
  }
}
