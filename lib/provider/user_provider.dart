import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    password: '',
  );
  User get user => _user;
  void setFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
