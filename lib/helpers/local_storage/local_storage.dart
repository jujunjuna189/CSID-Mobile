import 'dart:convert';

import 'package:csid_mobile/database/auth/model/model_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._privateConstructor();
  static final LocalStorage instance = LocalStorage._privateConstructor();

  Future<void> setAuth({String auth = ""}) async {
    final SharedPreferences refs = await SharedPreferences.getInstance();
    refs.setString("auth", auth);
  }

  Future<ModelLogin> getAuth() async {
    final SharedPreferences refs = await SharedPreferences.getInstance();
    return ModelLogin.fromJson(jsonDecode(refs.getString("auth") ?? ""));
  }
}
