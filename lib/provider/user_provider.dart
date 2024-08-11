import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    name: '',
    id: '',
    email: '',
    password: '',
    token: '',
    skills: [],
  );
  User get user => _user;
  void setFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  void setUser(String user) {
    print("set user called in provider");
    _user = User.fromJson(user);
    print("after user called in provider");

    notifyListeners();
  }
}
