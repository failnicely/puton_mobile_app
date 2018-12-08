import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/routes.dart';
import 'package:puton/const/style.dart';
import 'package:puton/db/db_helper.dart';
import 'package:puton/http/post.dart';
import 'package:puton/redux/reducer/feed.dart';
import 'package:puton/redux/reducer/index.dart';
import 'package:puton/redux/reducer/tab.dart';
import 'package:puton/redux/reducer/user.dart';
import 'package:puton/redux/store/app_state.dart';
import 'package:puton/redux/store/post.dart';
import 'package:puton/redux/store/user.dart';
import 'package:puton/screen/tab/feed_tab.dart';
import 'package:puton/screen/tab/my_tab.dart';
import 'package:puton/screen/tab/notification_tab.dart';
import 'package:puton/screen/tab/search_tab.dart';
import 'package:puton/screen/tab/upload_post_tab.dart';
import 'package:puton/widget/shared/app_bar.dart';
import 'package:puton/widget/shared/button.dart';
import 'package:puton/widget/tab_bar.dart';
import 'package:redux/redux.dart';


class MainTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, int>(
          converter: (store) => store.state.tabPosition,
          builder: (context, currentTab) => _build(context, currentTab)
      );

  Widget _build(context, int currentTab) =>
      Scaffold(
          endDrawer: SizedBox(
            width: 250,
            child: _buildDrawer(context),
          ),
          appBar: EmptyAppBar(color: PColor.white),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(child: _buildTab(currentTab), flex: 1),
                _buildCustomTabBar(currentTab),
              ]
          )
      );

  Widget _buildDrawer(context) =>
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(),
            _buildMenuLine(),
            _buildDrawerMenu(context, '프로필 편집', Routes.EDIT_PROFILE),
//            _buildDrawerMenu(context, '계정', Routes.EDIT_PROFILE),
            _buildDrawerMenu(context, 'PTN', Routes.PTN_TOKEN, ptn: 100),
//            _buildDrawerMenu(context, '알림', Routes.EDIT_PROFILE),
            _buildLogout(),
          ],
        ),
          );

  Widget _buildDrawerHeader() =>
      Container(
        height: 80.0,
        child: DrawerHeader(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.only(top: 3, left: 14, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(flex: 1, child: Container()),
                Text('@pretycul', style: PStyle.drawerId),
              ],
            ),
        ),
      );

  Widget _buildDrawerMenu(context, text, routeName, {ptn}) =>
      InkWell(
        onTap: () => Navigator.popAndPushNamed(context, routeName),
        child: Column(
          children: [
            Container(
              height: 45,
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(text, style: PStyle.drawerMenu),
                  Flexible(flex: 1, child: Container()),
                  ptn != null ? _buildPtnAmount(context, ptn, routeName) : Container(),
                  Image.asset('image/icon/arrow_gray.png', width: 6, height: 10),
                ],
              ),
            ),
            _buildMenuLine(),
          ],
        ),
      );

  Padding _buildPtnAmount(context, ptn, routeName) =>
      Padding(
        padding: EdgeInsets.all(10),
        child: PButton(
            ptn.toString(),
            width: 35,
            height: 20,
            onPressed: () => Navigator.popAndPushNamed(context, routeName)
        ),
      );

  Widget _buildMenuLine() =>
      Container(height: 1, color: PColor.gray6);

  Widget _buildLogout() =>
      StoreConnector<AppState, User>(
          converter: (store) => store.state.user,
          builder: (context, user) =>
      MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          print('logout');
          store.dispatch(ClearUserAction());
          DBHelper().clearUser();
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, Routes.HOME);
        },
        child: Container(
          height: 45.0,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 14),
          child: Text('@${user.userId} 에서 로그아웃', style: PStyle.drawerLogout),
        ),
      ),
      );

  Widget _buildTab(currentTab) =>
      currentTab == 0
          ? FeedTab()
          : currentTab == 1
          ? SearchTab()
          : currentTab == 3
          ? NotificationTab()
          : MyTab();

  Widget _buildCustomTabBar(int currentTab) =>
      CustomTabBar(
        current: currentTab,
        onClickTab: (int position) => store.dispatch(ChangeTabAction(position)),
      );
}
