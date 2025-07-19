import 'package:csid_mobile/pages/greetings/model/model.dart';
import 'package:flutter/material.dart';

class PageGreetings extends StatelessWidget {
  const PageGreetings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: ScreenData.data.length,
        itemBuilder: (_, i) {
          return ScreenData.data[i].screen;
        },
      ),
    );
  }
}
