import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvent { home, search, chat, notifications, profile }

class NavigationBloc extends Bloc<NavigationEvent, int> {
  NavigationBloc() : super(0);

  Stream<int> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.home:
        yield 0;
        break;
      case NavigationEvent.search:
        yield 1;
        break;
      case NavigationEvent.chat:
        yield 2;
        break;
      case NavigationEvent.notifications:
        yield 3;
        break;
      case NavigationEvent.profile:
        yield 4;
        break;
    }
  }
}
