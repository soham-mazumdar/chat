import 'package:chat/redux/actions/allActions.dart';
import 'package:chat/redux/models/app_state.dart';
import 'package:chat/redux/services/firestore.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> dbMiddleware(
  FirestoreService firestoreService,
){
	return[
	  TypedMiddleware<AppState, SendMsgAction>(_sendMsg(firestoreService)),
  ];
}

void Function(Store<AppState> store, SendMsgAction action, NextDispatcher next)
_sendMsg(FirestoreService firestoreService) {
  	return (store, action, next) {

      firestoreService.addDoc(action.msg);//.then((value){});
      
    	next(action);
	};
}
