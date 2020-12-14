import 'package:chat/redux/middleware/AuthMiddleware.dart';
import 'package:chat/redux/services/AuthService.dart';
import 'package:chat/redux/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat/redux/middleware/DBMiddleware.dart';
import 'package:chat/redux/middleware/navigation_middleware.dart';
import 'package:chat/redux/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddleWare(
  GlobalKey<NavigatorState> navigatorKey,
  AuthService authService,
  FirestoreService firestoreService
)
{
  return [
    ...authMiddleware(authService),
    ...createNavigationMiddleware(navigatorKey),
    ...dbMiddleware(firestoreService),
  ];
}