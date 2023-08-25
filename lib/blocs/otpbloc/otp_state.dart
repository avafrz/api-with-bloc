import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class OtpState extends Equatable {}

class OtpInitialState extends OtpState {
  @override
  List<Object?> get props => [];
}

class OtpSuccess extends OtpState {
  @override
  List<Object?> get props => [];
}

class OtpEmpty extends OtpState {

  @override
  List<Object?> get props => [];
}

class OtpErrorState extends OtpState {
  final String error;
  OtpErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
