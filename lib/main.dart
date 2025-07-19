import 'package:csid_mobile/configs/config.dart';
import 'package:csid_mobile/routes/route_generate.dart';
import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Config.easyLoading();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...RouteGenerate.pageProvider(context)],
      child: MaterialApp(
        title: const String.fromEnvironment("APP_NAME"),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ThemeApp.color.dark),
          scaffoldBackgroundColor: ThemeApp.color.dark,
          bottomSheetTheme: BottomSheetThemeData(
            surfaceTintColor: ThemeApp.color.dark,
          ),
          useMaterial3: true,
        ),
        initialRoute: RouteName.INITIAL,
        onGenerateRoute: RouteGenerate.onRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
