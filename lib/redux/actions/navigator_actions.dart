import 'package:flutter/material.dart';
import 'package:chat/redux/actions/action.dart';

class NavigatorPushAction extends AppAction{

  final String route;
  final dynamic data;
  NavigatorPushAction(this.route, {this.data});

  @override String toString() => "NavigatorPushAction{$route}:{$data}";
}

class NavigatorReplaceAction extends AppAction{

  final String route;
  final dynamic data;
  NavigatorReplaceAction(this.route, {this.data});

  @override String toString() => "NavigatorReplaceAction{$route}:{$data}";
}

class PushDialogAction extends AppAction{
	final Widget Function(BuildContext context) widgetBuilder;
	final BuildContext context;
	final bool autoHide;
	PushDialogAction(
		this.widgetBuilder, {
		this.context,
		this.autoHide
	});
	@override String toString() => "PushDialogAction";
}

class PushedDialogAction extends AppAction{
	final Future<dynamic> dialogFuture;
	PushedDialogAction(this.dialogFuture);

	@override String toString() => "PushedDialogAction";
}

class PoppedDialogAction extends AppAction{
	final Future<dynamic> dialogFuture;
	PoppedDialogAction(this.dialogFuture);

	@override String toString() => "PoppedDialogAction";
}

class NavigatorPopAction extends AppAction{
  @override String toString() => "NavigatorPopAction{}";
}
