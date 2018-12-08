import 'dart:async';
import 'dart:convert';

import 'package:puton/http/user.dart';
import 'package:puton/redux/reducer/index.dart';
import 'package:puton/redux/reducer/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/routes.dart';
import 'package:puton/const/style.dart';
import 'package:puton/db/db_helper.dart';
import 'package:puton/db/model/user.dart';
import 'package:puton/redux/reducer/user.dart';
import 'package:puton/redux/store/app_state.dart';
import 'package:puton/widget/shared/logo.dart';

class HomeScreen extends StatelessWidget {
  static const platform = const MethodChannel('puton.failnicely.com/nova');

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Builder(
          builder: (context) =>
              Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [PColor.secondary, PColor.primary], // whitish to gray
                      tileMode: TileMode.repeated, // repeats the gradient over the canvas
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: Container(), flex: 3),
                      _buildIdentity(context),
                      Container(height: 40),
                      _buildInformation(),
                      Flexible(child: Container(), flex: 2),
                      _buildLoginButton(),
                      Flexible(child: Container(), flex: 2),
//                      _buildStartWithNova(), //todo: link to nova create user
                    ],
                  )
              ),
        ),
      );

  Widget _buildIdentity(context) =>
      StoreConnector<AppState, AppState>(
        onInitialBuild: (_) => _loginCheck(context),
        converter: (store) => store.state,
        builder: (context, post) => Center(child: _buildLogo()),
      );

  Widget _buildInformation() =>
      Center(
          child: Container(
              width: 280,
              child: Text(
                'Puton is a service for holders with an EOS account. Creating an EOS account is not supported.',
                textAlign: TextAlign.center,
                style: PStyle.splashInformation,
              )
          )
      );

  Widget _buildLoginButton() =>
      StoreConnector<AppState, bool>(
          converter: (store) => store.state.splash.shouldShowLoginButton,
          builder: (context, shouldShowLoginButton) =>
            shouldShowLoginButton
                ? _buildButton(context)
                : _buildPleaseWait()
      );

  Widget _buildButton(BuildContext context) =>
      Material(
        color: PColor.transparent,
        child: InkWell(
          onTap: () => _login(context),
          splashColor: PColor.white,
          highlightColor: PColor.primary,
          borderRadius: BorderRadius.all(Radius.circular(32)),
          child: Opacity(
            opacity: 0.8,
            child: Container(
              width: 250,
              height: 45,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [PColor.nova1, PColor.nova2], // whitish to gray
                  tileMode: TileMode.repeated, // repeats the gradient over the canvas
                ),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: Center(
                child: Text('Login with NOVA', style: PStyle.bigWhite),
              ),
            ),
          ),
        ),
      );

  Widget _buildPleaseWait() =>
      Container(
          height: 45,
          child: Center(
            child: Text('Please Wait...', style: PStyle.bigWhite),
          )
      );

  Widget _buildStartWithNova() =>
      Material(
          color: PColor.transparent,
          child: InkWell(
            onTap: () => null,
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    color: PColor.white,
                    height: 60,
                  ),
                ),
                Container(
                    color: PColor.transparent,
                    height: 60,
                    child: Center(
                      child: Text(
                        'Don’t have account? Start with Nova',
                        textAlign: TextAlign.center,
                        style: PStyle.splashInformation,
                      ),
                    )
                ),
              ],
            ),
          )
      );

  Widget _buildLogo() =>
      Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: Logo(size: LogoSize.BIG, logoColor: LogoColor.WHITE)
      );

  _login(context) async {
    try {
      final String result = await platform.invokeMethod('requestAccount');
      print(result);
      final json = jsonDecode(result);
      print('requestAccount: $json');
      final msg = json['msg'];
      final code = json['code'];
      final name = json['name'];
      final balance = json['balance'];
      final raw = json['raw'];

      if (_isAuthorized(msg, code, name)) {
        var user = User(username: name, balance: balance, raw: raw);
        DBHelper().clearUser();
        DBHelper().saveUser(user);

        var action = RegisterUserAction(
          userId: user.username,
          username: user.username,
          balance: double.parse(user.balance.replaceAll('EOS', '').trim()),
          ptnBalance: 0,
        );
        store.dispatch(action);

        final usernames = await listUsername();
        if (usernames.contains(name)) {
          Navigator.pushReplacementNamed(context, Routes.MAIN_TAB);
          return;
        }

        String result = await platform.invokeMethod('createUser', {'username': name});
        print('createUser: $result');
        Navigator.pushReplacementNamed(context, Routes.MAIN_TAB);
        return;
      }

      _showFailMessageAndFinishApp(context);
    } catch (err) {
      print(err);
      _showErrorMessageAndFinishApp(context, err);
    }
  }

  _loginCheck(context) async {
    print('_loginCheck');
    List<User> users = await DBHelper().getUsers();
    print(users);
    print(users.length);

    if (users != null && users.length > 0) {
      var user = users[0];
      var action = RegisterUserAction(
        userId: user.username,
        username: user.username,
        balance: double.parse(user.balance.replaceAll('EOS', '').trim()),
        ptnBalance: 0,
      );
      store.dispatch(action);
      Navigator.pushReplacementNamed(context, Routes.MAIN_TAB);
      return;
    }

    store.dispatch(HandlerUserIsNotLoadedAction());
  }

  bool _isAuthorized(msg, code, name) =>
      msg == 'success' && code == '0' && name != null && name.length > 0;

  void _showFailMessageAndFinishApp(context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('로그인에 실패했습니다.')));
  }

  void _showErrorMessageAndFinishApp(context, err) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('로그인 중 에러가 발생했습니다.')));
  }
}
