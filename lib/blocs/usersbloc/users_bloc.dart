import 'dart:convert';

import 'package:apiwithbloc/blocs/usersbloc/users_event.dart';
import 'package:flutter/material.dart';
import '../../model/data.dart';

import '../../services/token_provider.dart';
import '/services/api_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(BuildContext context)
      : super(UsersInitialState()) {
    on<LoadUsersEvent>((event, emit) async {
     
      emit(UsersInitialState());
       
      var response = await userData(context);
      if (response.statusCode == 200) {
        var myUser = Users.fromJson(response.data);
        emit(UsersSuccess(myUser));
      } else {
        throw Exception('Failed to load user');
      }
    });
  }
}
