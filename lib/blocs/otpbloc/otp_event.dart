import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


@immutable
abstract class OtpEvent extends Equatable {
  const OtpEvent();
}

class SubmitOtpEvent extends OtpEvent {
  final int loginCode;

  SubmitOtpEvent(this.loginCode);

  @override
  List<Object?> get props => [loginCode];
}
