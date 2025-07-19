import 'package:flutter_bloc/flutter_bloc.dart';

class BlocGreetings extends Cubit<Map<String, dynamic>> {
  BlocGreetings() : super({});

  @override
  void onChange(Change<Map<String, dynamic>> change) {
    super.onChange(change);
  }
}
