import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvent { home, search, chat, notifications, profile }

class NavigationBloc extends Bloc<NavigationEvent, int> {
  NavigationBloc() : super(0) {
    on<NavigationEvent>((event, emit) {
      emit(NavigationEvent.values.indexOf(event));
    });
  }
}
