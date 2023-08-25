import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PhoneNumberEvent extends Equatable {
  const PhoneNumberEvent();
}

class SubmitPhoneNumberEvent extends PhoneNumberEvent {
  final String phoneNo;

  SubmitPhoneNumberEvent(this.phoneNo);

  @override
  List<Object?> get props => [phoneNo];
}
