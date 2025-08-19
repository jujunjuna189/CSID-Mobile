import 'dart:convert';

import 'package:csid_mobile/helpers/request/request_api.dart';
import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/widgets/molecules/modal/modal_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocForgotPassword extends Cubit<Map<String, dynamic>> {
  BlocForgotPassword() : super({});

  TextEditingController emailController = TextEditingController();

  void onForgot(BuildContext context) {
    Map<String, String> dataBatch = {
      "email": emailController.text,
    };

    RequestApi().post(path: "forgot-password", body: dataBatch).then((res) async {
      if (!context.mounted) return;
      final raw = jsonDecode(res.body);
      if ([200, 201].contains(res.statusCode)) {
        ModalMessage.show(
          context,
          title: "Forgot Password",
          message: raw['message'] ?? '-',
          confirmText: "Back To Login",
          onConfirm: () => Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) Navigator.of(context).pushNamedAndRemoveUntil(RouteName.LOGIN, (route) => false);
          }),
        );
      } else {
        ModalMessage.show(
          context,
          title: "Forgot Password",
          message: raw['message'] ?? '-',
          confirmText: "Back To Signup",
        );
      }
    });
  }

  @override
  void onChange(Change<Map<String, dynamic>> change) {
    super.onChange(change);
  }
}
