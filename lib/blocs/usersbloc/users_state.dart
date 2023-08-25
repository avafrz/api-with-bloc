import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../model/data.dart';

@immutable
abstract class UsersState extends Equatable {}

class UsersInitialState extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersSuccess extends UsersState {
  Users users;
  UsersSuccess(this.users);
  @override
  List<Object?> get props => [users];
}

class UsersEmpty extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersErrorState extends UsersState {
  final String error;
  UsersErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
