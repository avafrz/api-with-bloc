import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PhoneNumberState extends Equatable {}

class PhoneNumberInitialState extends PhoneNumberState {
  @override
  List<Object?> get props => [];
}

class PhoneNumberSuccess extends PhoneNumberState {
  @override
  List<Object?> get props => [];
}

class PhoneNumberEmpty extends PhoneNumberState {

  @override
  List<Object?> get props => [];
}

class PhoneNumberErrorState extends PhoneNumberState {
  final String error;
  PhoneNumberErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
