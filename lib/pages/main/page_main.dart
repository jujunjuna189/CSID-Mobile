import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csid_mobile/pages/main/bloc/bloc_main.dart';
import 'package:csid_mobile/pages/main/model/model.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/molecules/navigator/navigator_bottom.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  late BlocMain blocMain;

  @override
  void initState() {
    super.initState();
    blocMain = context.read<BlocMain>();
    blocMain.pageController = PageController(initialPage: 0);
    blocMain.videoController = YoutubePlayerController(
      initialVideoId: "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    blocMain.pageController.dispose();
    if (blocMain.videoController?.value.isPlaying == true) blocMain.videoController?.pause();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (blocMain.videoController != null) blocMain.videoController?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      ThemeApp.color.light,
                      ThemeApp.color.primary,
                      ThemeApp.color.secondary,
                      ThemeApp.color.dark
                    ],
                    center: const Alignment(0, 1),
                    radius: 1.2,
                  ),
                ),
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    controller: blocMain.pageController,
                    itemBuilder: (_, i) {
                      return PageData.data[i].screen;
                    }),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: blocMain.videoController!,
              builder: (context, value, _) {
                return value.isFullScreen
                    ? Container()
                    : NavigatorBottom(
                        onJump: (value) {
                          if (blocMain.videoController?.value.isPlaying == true) blocMain.videoController?.pause();
                          blocMain.pageController.jumpToPage(value);
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
