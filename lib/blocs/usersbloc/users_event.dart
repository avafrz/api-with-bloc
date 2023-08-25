import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


@immutable
abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class LoadUsersEvent extends UsersEvent {
 
  @override
  List<Object?> get props => [];
}
