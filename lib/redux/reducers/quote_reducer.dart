import 'package:chat/redux/actions/action.dart';
import 'package:redux/redux.dart';


final loadingReducer = combineReducers<bool>([new TypedReducer<bool, IsLoadingAction>(_isLoading)]);
bool _isLoading(bool meds, IsLoadingAction action) => action.isLoading;
