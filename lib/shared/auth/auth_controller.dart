import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user; // operador "_" define uma variavel privada

  get user => _user!;
  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJSON());
    return;
  }

  void logoutUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove('user');

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
      (route) => false,
    );
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey('user')) {
      final user = instance.getString('user') as String;
      setUser(context, UserModel.fromJSON(user));
      return;
    } else {
      setUser(context, null);
    }
  }
}
