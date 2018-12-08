
import 'package:meta/meta.dart';

class User {
  final String userId;
  final String username;
  final String profileImg;
  final double balance;
  final double ptnBalance;

  User({
    @required this.userId,
    @required this.username,
    this.profileImg,
    this.balance,
    @required this.ptnBalance,
  });

  User.init({
    this.profileImg,
  })
      :
        this.userId = '',
        this.username = '',
        this.balance = 0,
        this.ptnBalance = 0;

  User copyWith({
    String userId,
    String username,
    String profileImg,
    double balance,
    double ptnBalance,
  }) =>
      User(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        profileImg: profileImg ?? this.profileImg,
        balance: balance ?? this.balance,
        ptnBalance: ptnBalance ?? this.ptnBalance,
      );

  @override
  String toString() {
    return 'User{userId: $userId, username: $username, profileImg: $profileImg, balance: $balance, ptnBalance: $ptnBalance}';
  }

}
