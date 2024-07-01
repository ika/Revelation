import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// -------------------------------------------------
// Event
// -------------------------------------------------
@immutable
abstract class ScrollEvent {}

class UpdateScroll extends ScrollEvent {
  UpdateScroll({required this.index});
  final int index;
}

// -------------------------------------------------
// Bloc
// -------------------------------------------------
class ScrollBloc extends HydratedBloc<ScrollEvent, int> {
  ScrollBloc() : super(0) {
    on<UpdateScroll>((event, emit) {
      emit(event.index);
    });
  }

  @override
  int? fromJson(Map<String, dynamic> json) => json['scrollto'] as int;

  @override
  Map<String, dynamic>? toJson(int state) => {'scrollto': state};
}
