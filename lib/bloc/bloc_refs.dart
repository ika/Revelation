import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// -------------------------------------------------
// Event
// -------------------------------------------------
@immutable
abstract class RefsEvent {}

class ChangeRefs extends RefsEvent {
  ChangeRefs({required this.refsAreOn});
  final bool refsAreOn;
}

// -------------------------------------------------
// Bloc Ref numbers on or off
// -------------------------------------------------
class RefsBloc extends HydratedBloc<RefsEvent, bool> {
  RefsBloc() : super(false) {
    on<ChangeRefs>((event, emit) {
      emit(event.refsAreOn);
    });
  }

  @override
  bool? fromJson(Map<String, dynamic> json) => json['refs'] as bool;

  @override
  Map<String, dynamic>? toJson(bool state) => {'refs': state};
}

