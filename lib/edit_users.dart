import 'dart:convert';
import 'package:bloc_demo/user_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController filterKeyword = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerJob = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();

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
          title: const Padding(
            padding: EdgeInsets.only(left: 100),
            child: Text("Edit User"),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: getbody(),
    );
  }

  getbody() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: _controllerId,
          decoration: const InputDecoration(hintText: "Id:"),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _controllerAge,
          decoration: const InputDecoration(hintText: "Age:"),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _controllerJob,
          decoration: const InputDecoration(hintText: "Job:"),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _controllerName,
          decoration: const InputDecoration(hintText: "Name:"),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _controllerEmail,
          decoration: const InputDecoration(hintText: "Email:"),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _controllerPhoneNumber,
          decoration: const InputDecoration(hintText: "PhoneNumber:"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            letEdit();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserList(),
                ));
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 28, 160, 183)),
          child: const Text(
            "Update",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
        print("Up date Successfully!!!");
        return result;
      } else {
        print(response.statusCode);
        var messageError = "Can not update this user!!";
        print(messageError);
      }
    }
  }
}
