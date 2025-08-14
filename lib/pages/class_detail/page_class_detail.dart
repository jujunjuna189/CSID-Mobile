import 'dart:convert';

import 'package:csid_mobile/helpers/formatter/formatter_price.dart';
import 'package:csid_mobile/pages/class_detail/bloc/bloc_class_detail.dart';
import 'package:csid_mobile/pages/class_detail/state/state_class_detail.dart';
import 'package:csid_mobile/pages/class_detail/widget/shimmer.dart';
import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PageClassDetail extends StatefulWidget {
  const PageClassDetail({super.key});

  @override
  State<PageClassDetail> createState() => _PageClassDetailState();
}

class _PageClassDetailState extends State<PageClassDetail> {
  late BlocClassDetail blocMain;

  @override
  void initState() {
    super.initState();
    blocMain = context.read<BlocClassDetail>();
  }

  @override
  void dispose() {
    super.dispose();
    if (blocMain.videoController?.value.isPlaying == true) blocMain.videoController?.pause();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (blocMain.videoController != null) blocMain.videoController?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [ThemeApp.color.light, ThemeApp.color.primary, ThemeApp.color.secondary, ThemeApp.color.dark],
              center: const Alignment(0, 1),
              radius: 1.2,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: ThemeApp.color.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: ThemeApp.color.white,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        colors: [const Color.fromRGBO(87, 44, 220, 1), ThemeApp.color.light],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: ThemeApp.color.dark,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: SizedBox(
                        width: 49,
                        height: 49,
                        child: BlocBuilder<BlocClassDetail, StateClassDetail>(
                          bloc: blocMain,
                          builder: (context, state) {
                            final currentState = state as ClassDetailLoaded;
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                currentState.auth?.avatar ?? '',
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.account_circle, size: 50, color: Colors.grey);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<BlocClassDetail, StateClassDetail>(
                  bloc: blocMain,
                  builder: (context, state) {
                    final currentState = state as ClassDetailLoaded;
                    if (currentState.course?.thumbnail == null || currentState.course?.thumbnail == "") {
                      return Container(
                        width: 250,
                        height: 400,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ThemeApp.color.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }
                    return Container(
                      width: 250,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ThemeApp.color.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                currentState.course?.thumbnail ?? '',
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image, size: 50, color: Colors.grey);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentState.course?.title ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: ThemeApp.font.bold.copyWith(
                                        fontSize: 24,
                                        height: 1.2,
                                        color: ThemeApp.color.dark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: RichText(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              style: ThemeApp.font.regular.copyWith(
                                                color: ThemeApp.color.dark.withOpacity(0.5),
                                              ),
                                              children: [
                                                const TextSpan(text: 'by '),
                                                TextSpan(
                                                    text: currentState.course?.authorName ?? '',
                                                    style: ThemeApp.font.semiBold),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(Asset.icUser),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              (currentState.course?.enrolledCount).toString(),
                                              style: ThemeApp.font.semiBold.copyWith(
                                                fontSize: 12,
                                                color: ThemeApp.color.dark.withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: ThemeApp.color.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  FormatterPrice.instance.formatToK((currentState.course?.salePrice ?? 0)),
                                  style: ThemeApp.font.semiBold.copyWith(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Button(
                                  onPress: () => Navigator.of(context).pushNamed(
                                    RouteName.ORDER,
                                    arguments: jsonEncode(
                                      {'course_id': currentState.course?.id},
                                    ),
                                  ),
                                  child: Text(
                                    "Purchase Now",
                                    textAlign: TextAlign.center,
                                    style: ThemeApp.font.medium.copyWith(color: ThemeApp.color.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Preview",
                    style: ThemeApp.font.bold.copyWith(fontSize: 14, color: ThemeApp.color.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 194,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: ThemeApp.color.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BlocBuilder<BlocClassDetail, StateClassDetail>(
                  bloc: blocMain,
                  builder: (context, state) {
                    final currentState = state as ClassDetailLoaded;
                    if (currentState.previews?.metaValue?.first.youtubeUrl == null ||
                        currentState.previews?.metaValue?.first.youtubeUrl == "") {
                      return Container();
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: YoutubePlayer(
                        controller: blocMain.videoController!,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: ThemeApp.color.light,
                        progressColors: ProgressBarColors(
                          playedColor: ThemeApp.color.primary,
                          handleColor: ThemeApp.color.primary,
                        ),
                        bottomActions: const [],
                        thumbnail: Image.network(
                          currentState.course?.thumbnail ?? "",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image, size: 50, color: Colors.grey);
                          },
                        ),
                        onReady: () {
                          blocMain.loadVideo(blocMain.videoSources ?? "");
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<BlocClassDetail, StateClassDetail>(
                bloc: blocMain,
                builder: (context, state) {
                  final currentState = state as ClassDetailLoaded;
                  if ((currentState.previews?.metaValue ?? []).isEmpty) {
                    return const Shimmer();
                  }
                  return Column(
                    children: (currentState.previews?.metaValue ?? []).asMap().entries.map((item) {
                      return GestureDetector(
                        onTap: () {
                          blocMain.loadVideo(blocMain.videoSources = item.value.youtubeUrl ?? "");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: ThemeApp.color.white.withOpacity(0.1),
                            border: Border.all(width: 1, color: ThemeApp.color.white.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  item.value.title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: ThemeApp.font.semiBold.copyWith(fontSize: 14, color: ThemeApp.color.white),
                                ),
                              ),
                              Text(
                                item.value.duration ?? '',
                                style: ThemeApp.font.semiBold.copyWith(fontSize: 14, color: ThemeApp.color.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
