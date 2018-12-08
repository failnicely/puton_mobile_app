import 'package:meta/meta.dart';
import 'package:puton/redux/store/user.dart';
import 'package:redux/redux.dart';

class ClearUserAction {}

class RegisterUserAction {
  final String userId;
  final String username;
  final String profileImg;
  final double balance;
  final double ptnBalance;

  RegisterUserAction({
    @required this.userId,
    @required this.username,
    this.profileImg,
    this.balance,
    @required this.ptnBalance,
  });
}

User _clearUser(User user, ClearUserAction action) =>
    User.init();

User _registerUser(User user, RegisterUserAction action) =>
    user.copyWith(
      userId: action.userId,
      username: action.username,
      profileImg: action.profileImg,
      balance: action.balance,
      ptnBalance: action.ptnBalance,
    );

final Reducer<User> userReducer = combineReducers<User>([
  TypedReducer<User, ClearUserAction>(_clearUser),
  TypedReducer<User, RegisterUserAction>(_registerUser),
]);
