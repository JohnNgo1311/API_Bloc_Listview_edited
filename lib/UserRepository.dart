import 'dart:convert';
import 'UserRepository.dart';
import "package:bloc/bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:bloc_demo/Model/User_Model.dart';

// UserRepository
class UserRepository {
  String Url = 'https://retoolapi.dev/PA89FB/data';
  Future<List<UserModel>> getUsers() async {
    Response response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
