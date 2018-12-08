
import 'package:meta/meta.dart';
import 'package:puton/redux/store/feed.dart';
import 'package:puton/redux/store/personal.dart';
import 'package:puton/redux/store/splash.dart';
import 'package:puton/redux/store/upload.dart';
import 'package:puton/redux/store/user.dart';

class AppState {
  final int tabPosition;
  final Personal personal;
  final Upload upload;
  final Splash splash;
  final Feed feed;
  final User user;

  AppState({
    @required this.tabPosition,
    @required this.personal,
    @required this.upload,
    @required this.splash,
    @required this.feed,
    @required this.user,
  });

  AppState.init()
      :
        tabPosition = 0,
        personal = Personal.init(),
        upload = Upload.init(),
        splash = Splash.init(),
        feed = Feed.init(),
        user = User.init();

  @override
  String toString() {
    return 'AppState{tabPosition: $tabPosition, personal: $personal, upload: $upload, splash: $splash, feed: $feed}';
  }

}
