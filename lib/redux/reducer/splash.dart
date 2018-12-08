import 'package:puton/redux/store/splash.dart';
import 'package:redux/redux.dart';

class HandlerUserIsNotLoadedAction {
}

Splash _setShouldShowLoginButton(Splash splash, HandlerUserIsNotLoadedAction action) =>
    splash.copyWith(shouldShowLoginButton: true);

final Reducer<Splash> splashReducer = combineReducers<Splash>([
  TypedReducer<Splash, HandlerUserIsNotLoadedAction>(_setShouldShowLoginButton),
]);
