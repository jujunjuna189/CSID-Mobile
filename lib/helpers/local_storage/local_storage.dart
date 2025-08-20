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
    final authString = refs.getString("auth");

    if (authString == null || authString.isEmpty) {
      return ModelLogin(id: 0); // atau return null kalau perlu
    }

    return ModelLogin.fromJson(jsonDecode(authString));
  }

  Future<void> clearAuth() async {
    final SharedPreferences refs = await SharedPreferences.getInstance();
    await refs.remove("auth");
  }

  Future<void> setPocket({String pocket = ""}) async {
    final SharedPreferences refs = await SharedPreferences.getInstance();
    refs.setString("pocket", jsonEncode(pocket));
  }

  Future<dynamic> getPocket() async {
    final SharedPreferences refs = await SharedPreferences.getInstance();
    final pocketString = refs.getString("pocket");

    if (pocketString == null || pocketString.isEmpty) {
      return null; // atau return null kalau perlu
    }

    return jsonDecode(pocketString);
  }

  Future<void> clearAll() async {
    final SharedPreferences refs = await SharedPreferences.getInstance();
    await refs.clear();
  }
}
