import 'dart:convert';
import "package:bloc_demo/UserRepository.dart";
import "package:bloc/bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// Model_Class_UserModel
class UserModel {
  int? id;
  int? age;
  String? job;
  String? name;
  String? email;
  String? phoneNumber;

  UserModel(
      {this.id, this.age, this.job, this.name, this.email, this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    age = json['Age'];
    job = json['Job'];
    name = json['Name'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
  }
}
