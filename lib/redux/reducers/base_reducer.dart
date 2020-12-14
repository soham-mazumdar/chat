
import 'package:chat/redux/models/app_state.dart';
import 'package:chat/redux/reducers/navigation_reducer.dart';
import 'package:chat/redux/reducers/quote_reducer.dart';

AppState baseReducer(AppState oldState, dynamic action)
{
  return oldState.copyWith(
    newRoutes: navigationReducer(oldState.routes, action),
    newIsLoading: loadingReducer(oldState.isLoading, action),
    // newQuotes: quoteReducer(oldState.quotes, action),
    // newSavedQuotes: saveLocalReducer(oldState.savedQuotes, action),
  );
}