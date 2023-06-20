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

//User_RestAPI_Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
    
    on<FilterUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        final usersList = users
            .where((value) => value.name!
                .toLowerCase()
                .contains(event.searchText.toLowerCase()))
            .toList();
        emit(UserLoadedState(usersList));

      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
