import 'package:meta/meta.dart';

class User{
  String username;
  String balance;
  String raw;

  User({
    @required this.username,
    this.balance,
    this.raw
  });

  @override
  String toString() {
    return 'User{username: $username, balance: $balance, raw: $raw}';
  }

}