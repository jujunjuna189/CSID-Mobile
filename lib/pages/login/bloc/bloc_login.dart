import 'dart:convert';

import 'package:csid_mobile/helpers/local_storage/local_storage.dart';
import 'package:csid_mobile/helpers/request/request_api.dart';
import 'package:csid_mobile/database/auth/model/model_login.dart';
import 'package:csid_mobile/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocLogin extends Cubit<Map<String, dynamic>> {
  BlocLogin() : super({});

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onLogin(BuildContext context) {
    var data = {
      "username": usernameController.text,
      "password": passwordController.text,
    };

    RequestApi().post(path: "login", body: data).then((res) async {
      if ([200, 201].contains(res.statusCode)) {
        await LocalStorage.instance
            .setAuth(auth: jsonEncode(ModelLogin.fromJson(jsonDecode(res.body)['user'])))
            .then((res) {
          if (context.mounted) Navigator.of(context).pushNamedAndRemoveUntil(RouteName.MAIN, (route) => false);
        });
      }
    });
  }

  @override
  void onChange(Change<Map<String, dynamic>> change) {
    super.onChange(change);
  }
}
