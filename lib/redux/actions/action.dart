abstract class AppAction{}

class InitAppAction extends AppAction {

  InitAppAction();

  @override @override String toString() {
    return "InitAppAction";
  }
}

class IsLoadingAction extends AppAction{
  final bool isLoading;
  IsLoadingAction(this.isLoading);

  @override String toString() => "IsLoadingAction{$isLoading}";
}

class LoadedAction extends AppAction{}

class AllLoadedAction extends AppAction {

  AllLoadedAction();

  @override @override String toString() {
    return "AllLoadedAction";
  }
}
