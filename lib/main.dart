import 'package:chat/redux/services/AuthService.dart';
import 'package:chat/redux/services/firestore.dart';
import 'package:chat/ui/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:chat/redux/actions/action.dart';
import 'package:chat/redux/middleware/middleware.dart';
import 'package:chat/redux/models/app_state.dart';
import 'package:chat/redux/reducers/base_reducer.dart';
import 'package:chat/redux/routes/routes.dart';
import 'package:chat/ui/ChatPage.dart';
import 'package:redux/redux.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  
  final Store<AppState> store = Store<AppState>(
    baseReducer,
    initialState: AppState.initial(),

    middleware: createMiddleWare(
      navigatorKey,
      AuthService(),
      FirestoreService()
    )
  );
  store.dispatch(InitAppAction());
  return runApp(ChatApp(store));
}

class ChatApp extends StatelessWidget {
  
  final Store<AppState> store;

  ChatApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, Map<String, dynamic>>(
        converter: (store)
        {
          final Map<String, dynamic> args = {
            "routes": store.state.routes,
          };
          return args;
        },
        builder: (context, args){
          final List<String> routes = args["routes"];
          return MaterialApp(
            initialRoute: routes.last,
            debugShowCheckedModeBanner : false,
            navigatorKey:navigatorKey,
            navigatorObservers: [routeObserver],
            theme: ThemeData(
              canvasColor: Colors.grey.shade900,
            ),
            onGenerateRoute: (RouteSettings settings) => _resolveRoute(settings),
          );
        }
      )
      
      
    );
  }

  PageRoute _resolveRoute(RouteSettings settings)
	{
    
		switch(settings.name)
		{
			case AppRoutes.login:
          return MainRoute(LoginPage(), settings: settings);
      case AppRoutes.chat:
          return MainRoute(ChatPage(), settings: settings);
      default :
        return MainRoute(LoginPage(), settings : settings,);
        
		}
	}

}