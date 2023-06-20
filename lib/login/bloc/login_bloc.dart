import 'dart:convert';
import "package:bloc_demo/UserRepository.dart";
import "package:bloc/bloc.dart";
import 'package:bloc_demo/login/bloc/login_event.dart';
import 'package:bloc_demo/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository = UserRepository();

  LoginBloc(this._userRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      bool check = false;
      emit(LoginLoading());
      try {
        final users = await _userRepository.getUsers();

        for (var user in users) {
          if (user.name == event.username &&
              user.phoneNumber == event.password) {
            check = true;
            break;
          }
        }
        emit(LoginLoaded(check: check));
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
