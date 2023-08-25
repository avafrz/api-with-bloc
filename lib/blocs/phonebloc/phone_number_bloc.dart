import 'package:apiwithbloc/services/token_provider.dart';
import 'package:flutter/material.dart';

import '/services/api_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'phone_number_state.dart';
import 'phone_number_event.dart';

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  PhoneNumberBloc(BuildContext context)
      : super(PhoneNumberInitialState()) {
    on<SubmitPhoneNumberEvent>((event, emit) async {
      emit(PhoneNumberInitialState());
      try {
        var response = await enterPhone(context, event.phoneNo);
        if (response.statusCode == 200) {
          TokenProvider.prefs.setString('phoneNo',event.phoneNo);
          emit(PhoneNumberSuccess());
        } else {
          throw Exception('error');
        }
      } catch (e) {
        emit(PhoneNumberErrorState(e.toString()));
      }
    });
  }
}
