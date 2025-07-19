import 'package:csid_mobile/pages/class_detail/bloc/bloc_class_detail.dart';
import 'package:csid_mobile/pages/class_detail/page_class_detail.dart';
import 'package:csid_mobile/pages/learning/bloc/bloc_learning.dart';
import 'package:csid_mobile/pages/main/bloc/bloc_main.dart';
import 'package:csid_mobile/pages/main/page_main.dart';
import 'package:csid_mobile/pages/greetings/bloc/bloc_greetings.dart';
import 'package:csid_mobile/pages/greetings/page_greetings.dart';
import 'package:csid_mobile/pages/login/bloc/bloc_login.dart';
import 'package:csid_mobile/pages/login/page_login.dart';
import 'package:csid_mobile/pages/register/bloc/bloc_register.dart';
import 'package:csid_mobile/pages/register/page_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csid_mobile/routes/route_name.dart';

class RouteGenerate {
  static Route onRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteName.INITIAL:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => BlocGreetings(),
            child: const PageGreetings(),
          ),
        );
      case RouteName.LOGIN:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => BlocLogin(),
            child: const PageLogin(),
          ),
        );
      case RouteName.REGISTER:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => BlocRegister(),
            child: const PageRegister(),
          ),
        );
      case RouteName.MAIN:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => BlocMain()..initialPage(),
            child: const PageMain(),
          ),
        );
      case RouteName.CLASS_DETAIL:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => BlocClassDetail(arguments: args is String ? args : '')..initialPage(),
            child: const PageClassDetail(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => _errorRoute());
    }
  }

  static List<dynamic> pageProvider(BuildContext context) {
    List<dynamic> providers = [
      BlocProvider(create: (context) => BlocGreetings()),
      BlocProvider(create: (context) => BlocLogin()),
      BlocProvider(create: (context) => BlocMain()),
      BlocProvider(create: (context) => BlocLearning()),
      BlocProvider(create: (context) => BlocClassDetail()),
    ];

    return providers;
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  }
}
