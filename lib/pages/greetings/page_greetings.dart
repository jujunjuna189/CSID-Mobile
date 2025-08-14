import 'package:csid_mobile/pages/greetings/model/model.dart';
import 'package:flutter/material.dart';

class PageGreetings extends StatefulWidget {
  const PageGreetings({super.key});

  @override
  State<PageGreetings> createState() => _PageGreetingsState();
}

class _PageGreetingsState extends State<PageGreetings> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: PageView.builder(
              controller: _controller,
              itemCount: ScreenData.data.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return ScreenData.data[i].screen;
              },
            ),
          ),
          (ScreenData.data.length - 1) != _currentIndex
              ? Positioned(
                  bottom: MediaQuery.of(context).size.height / 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      ScreenData.data.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: _currentIndex == index ? 50 : 20,
                        height: 5,
                        decoration: BoxDecoration(
                          color: _currentIndex == index ? Colors.white : Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.4), // warna shadow
                              blurRadius: 8, // seberapa blur
                              spreadRadius: 1, // seberapa lebar
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
