import 'dart:convert';
import "package:bloc_demo/UserRepository.dart";
import "package:bloc/bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:bloc_demo/Model/User_Model.dart';

// User_RestAPI_Event
@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}


class FilterUserEvent extends UserEvent {
  FilterUserEvent({required this.searchText});
  String searchText;
  @override
  List<Object> get props => [];
}
