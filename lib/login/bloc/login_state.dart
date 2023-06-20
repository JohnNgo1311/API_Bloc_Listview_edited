import 'dart:convert';
import "package:bloc_demo/UserRepository.dart";
import "package:bloc/bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:bloc_demo/Model/User_Model.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_event.dart';
import 'package:bloc_demo/User_getAPI/bloc/user_get_api_state.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  bool check = false;
  LoginLoaded({required this.check});
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
