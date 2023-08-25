import 'dart:convert';

import 'package:flutter/material.dart';
import '../../services/token_provider.dart';
import '/services/api_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc(BuildContext context) : super(OtpInitialState()) {
    on<SubmitOtpEvent>((event, emit) async {
      emit(OtpInitialState());

      String phone = TokenProvider.prefs.getString('phoneNo') ?? '';
      var accessToken = '';
      var refreshToken = '';
      print(phone);
      var response = await sendCode(context, phone, event.loginCode);
      if (response.statusCode == 200) {
        accessToken = jsonEncode(
            response.data['valueOrDefault']['tokens']['accesstoken']);
        TokenProvider.prefs.setString('accessToken', accessToken);

        refreshToken = jsonEncode(
            response.data['valueOrDefault']['tokens']['refreshToken']);
        TokenProvider.prefs.setString('refreshToken', refreshToken);
        print(refreshToken);
        emit(OtpSuccess());
      } else {
        emit(OtpErrorState('error'));
      }
    });
  }
}
