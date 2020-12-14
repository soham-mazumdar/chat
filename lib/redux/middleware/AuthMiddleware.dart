import 'package:chat/redux/actions/allActions.dart';
import 'package:chat/redux/actions/action.dart';
import 'package:chat/redux/actions/navigator_actions.dart';
import 'package:chat/redux/models/app_state.dart';
import 'package:chat/redux/routes/routes.dart';
import 'package:chat/redux/services/AuthService.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> authMiddleware(
  AuthService authService,
){
	return[
    TypedMiddleware<AppState, InitAppAction>(_init(authService)),
	  TypedMiddleware<AppState, SignInFBAction>(_signInFB(authService)),
    TypedMiddleware<AppState, SignOutAction >(_signOut(authService)),
    TypedMiddleware<AppState, RegisterWithEPAction>(_registerWithEP(authService)),
    TypedMiddleware<AppState, SignInWithEPAction>(_signInWithEP(authService)),
  ];
}

void Function(Store<AppState> store, InitAppAction action, NextDispatcher next)
_init(AuthService authService) {
  	return (store, action, next) {

      // if(FirebaseAuth.instance.currentUser == null)
      //   store.dispatch(NavigatorReplaceAction(AppRoutes.login));
      // else
      //   store.dispatch(NavigatorReplaceAction(AppRoutes.chat));
        
      
    	next(action);
	};
}

void Function(Store<AppState> store, SignInFBAction action, NextDispatcher next)
_signInFB(AuthService authService) {
  	return (store, action, next) async {
      
      
      authService.signInFb().then((value){
        // log(value.toString());
        
        print(store.state.isLoading);
        store.dispatch(NavigatorReplaceAction(AppRoutes.chat));
      });
      store.dispatch(IsLoadingAction(false));

    	next(action);
	};
}

void Function(Store<AppState> store, SignOutAction action, NextDispatcher next)
_signOut(AuthService authService) {
  	return (store, action, next) {
      
      store.dispatch(IsLoadingAction(true));
      authService.signOut().then((value){
        print('object');
        store.dispatch(NavigatorReplaceAction(AppRoutes.login));
        store.dispatch(IsLoadingAction(false));
      });

    	next(action);
	};
}

void Function(Store<AppState> store, RegisterWithEPAction action, NextDispatcher next)
_registerWithEP(AuthService authService) {
  	return (store, action, next) {

      authService.registerWithCred(action.mail, action.pass).then((value){
        store.dispatch(NavigatorReplaceAction(AppRoutes.chat));
      });

    	next(action);
	};
}

void Function(Store<AppState> store, SignInWithEPAction action, NextDispatcher next)
_signInWithEP(AuthService authService) {
  	return (store, action, next) {

      authService.signInCred(action.mail, action.pass).then((value){
        store.dispatch(NavigatorReplaceAction(AppRoutes.chat));
      });

    	next(action);
	};
}
