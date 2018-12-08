import 'package:puton/redux/reducer/feed.dart';
import 'package:puton/redux/reducer/personal.dart';
import 'package:puton/redux/reducer/splash.dart';
import 'package:puton/redux/reducer/tab.dart';
import 'package:puton/redux/reducer/upload.dart';
import 'package:puton/redux/reducer/user.dart';
import 'package:puton/redux/store/app_state.dart';
import 'package:redux/redux.dart';

final store = Store<AppState>(
  appReducer,
  initialState: AppState.init(),
//  middleware: [LoggingMiddleware.printer()],
);


AppState appReducer(AppState state, action) =>
    AppState(
      tabPosition: tabPositionReducer(state.tabPosition, action),
      personal: personalReducer(state.personal, action),
      upload: uploadReducer(state.upload, action),
      splash: splashReducer(state.splash, action),
      feed: feedReducer(state.feed, action),
      user: userReducer(state.user, action),
    );
