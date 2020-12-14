import 'package:chat/redux/actions/navigator_actions.dart';
import 'package:redux/redux.dart';

final navigationReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, NavigatorPushAction>(_navPush),
  TypedReducer<List<String>, NavigatorPopAction>(_navPop),
  TypedReducer<List<String>, NavigatorReplaceAction>(_navSetRoot),
]);

List<String> _navPush(List<String> routes, NavigatorPushAction action)
{
  List<String> oldRoutes = List<String>.from(routes);
  oldRoutes.add(action.route);
  return oldRoutes;
}

List<String> _navPop(List<String> routes, NavigatorPopAction action)
{
  List<String> oldRoutes = List<String>.from(routes);
  oldRoutes.removeLast();
  return oldRoutes;
}

List<String> _navSetRoot(List<String> routes, NavigatorReplaceAction action)
{
  return [action.route];
}



final dialogReducer = combineReducers<List<Future<dynamic>>>([
  TypedReducer<List<Future<dynamic>>, PushedDialogAction>(_dialogPush),
  TypedReducer<List<Future<dynamic>>, PoppedDialogAction>(_dialogPop),
]);

List<Future<dynamic>> _dialogPush(List<Future<dynamic>> dialogs, PushedDialogAction action)
{
  dialogs.add(action.dialogFuture);
  return dialogs;
}

List<Future<dynamic>> _dialogPop(List<Future<dynamic>> dialogs, PoppedDialogAction action)
{
  dialogs.remove(action.dialogFuture);
  return dialogs;
}
