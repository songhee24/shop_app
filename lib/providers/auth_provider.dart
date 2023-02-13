import 'package:flutter/widgets.dart';

class AuthProvider with ChangeNotifier {
  late final String _token;
  late final DateTime _expiryDate;
  late final String _userId;

  Future<void> signup(String email, String password) async {}
}
