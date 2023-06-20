import 'dart:convert';
import "package:bloc_demo/UserRepository.dart";
import "package:bloc/bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:bloc_demo/Model/User_Model.dart';

//User_States_RestAPI
@immutable
abstract class UserState extends Equatable {}

//data loading state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  UserLoadedState(this.users);
  final List<UserModel> users;

  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  UserErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}
