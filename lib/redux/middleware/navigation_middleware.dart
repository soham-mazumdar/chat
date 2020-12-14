import 'package:flutter/material.dart';
import 'package:chat/redux/actions/navigator_actions.dart';
import 'package:chat/redux/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createNavigationMiddleware(
	GlobalKey<NavigatorState> navigatorKey,
){
	return[
		TypedMiddleware<AppState, NavigatorPushAction>(_navigate(navigatorKey)),
    TypedMiddleware<AppState, NavigatorReplaceAction>(_setRoot(navigatorKey)),
    TypedMiddleware<AppState, PushDialogAction>(_pushDialog(navigatorKey)),
	];
}

void Function(Store<AppState> store, NavigatorPushAction action, NextDispatcher next)
_navigate(navigatorKey) {
  return (store, action, next) {
    final route = action.route;
    
    if (store.state.routes.last != route)
      {
        navigatorKey.currentState.pushNamed(route, arguments: action.data);
      }
    next(action);
	};
}

void Function(Store<AppState> store, NavigatorReplaceAction action, NextDispatcher next)
_setRoot(GlobalKey<NavigatorState> navigatorKey) {
	return (store, action, next) {
		final String route = action.route;
		navigatorKey.currentState.pushReplacementNamed(route, arguments : action.data);
		next(action);
	};
}

void Function(Store<AppState> store, PushDialogAction action,NextDispatcher next)
_pushDialog(GlobalKey<NavigatorState> navigatorKey)
{
	return (store, action, next) {
		next(action);

		// Future<dynamic> dialog = showDialog(
		// 	context: action.context ?? navigatorKey.currentContext,
		// 	barrierDismissible: action.autoHide ?? true,
		// 	builder: action.widgetBuilder,
		// );
    
    // -----
    Future<dynamic> dialog = showGeneralDialog(
      context: action.context ?? navigatorKey.currentContext,
      pageBuilder: (context, anim1, anim2) {},
      barrierDismissible: action.autoHide ?? true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) { 
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(anim1),
                  child: SlideTransition(
          	position: Tween<Offset>(
          		begin: const Offset(0.0,1.0),
          		end: Offset.zero,

          	).animate(anim1),
          	child: Builder(builder: action.widgetBuilder),
             // child is the value returned by pageBuilder
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 600)
    );
    // -----

		dialog.then((val){
			store.dispatch(PoppedDialogAction(dialog));
		});

		store.dispatch(PushedDialogAction(dialog));
	};
}
