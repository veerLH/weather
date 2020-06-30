

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate{

  @override
  void onEvent(Bloc bloc, Object event) {
    print('Event $event');
    super.onEvent(bloc, event);

  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print('Error $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("Transition $transition");
    super.onTransition(bloc, transition);
  }
}