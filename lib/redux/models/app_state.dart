import 'package:chat/redux/models/Msg.dart';
import 'package:chat/redux/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  final bool isLoading;
  final List<String> routes;
  final List<Msg> msgs;
  

  AppState({
    this.isLoading,
    this.routes,
    this.msgs,
  });

  factory AppState.initial(){
    return AppState(
      isLoading: false,
      routes: FirebaseAuth.instance.currentUser != null ? [AppRoutes.chat] : [AppRoutes.login],
      msgs: [],
    );
  }

  AppState copyWith({
    bool newIsLoading,
    List<String> newRoutes,
    List<Msg> newMsg,
  })
  {
    return AppState(
      isLoading: newIsLoading ?? this.isLoading,
      routes: newRoutes ?? this.routes,
      msgs: newMsg ?? this.msgs,
    );
  }
}