import 'package:csid_mobile/helpers/launcher/launcher.dart';
import 'package:csid_mobile/pages/learning_preview/bloc/bloc_learning_preview.dart';
import 'package:csid_mobile/pages/learning_preview/state/state_learning_preview.dart';
import 'package:csid_mobile/pages/learning_preview/widget/not_found.dart';
import 'package:csid_mobile/pages/learning_preview/widget/shimmer.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:csid_mobile/widgets/atoms/header/header_sticky.dart';
import 'package:csid_mobile/widgets/molecules/dropdown/dropdown_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PageLearningPreview extends StatefulWidget {
  const PageLearningPreview({super.key});

  @override
  State<PageLearningPreview> createState() => _PageLearningPreviewState();
}

class _PageLearningPreviewState extends State<PageLearningPreview> {
  late BlocLearningPreview blocLearningPreview;

  @override
  void initState() {
    blocLearningPreview = context.read<BlocLearningPreview>();
    blocLearningPreview.videoController = YoutubePlayerController(
      initialVideoId: "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  void onPause(Function? navigation) {
    if (blocLearningPreview.videoController?.value.isPlaying == true) blocLearningPreview.videoController?.pause();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (navigation != null) navigation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (blocLearningPreview.videoController?.value.isPlaying == true) blocLearningPreview.videoController?.pause();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (blocLearningPreview.videoController != null) blocLearningPreview.videoController?.dispose();
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
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: blocLearningPreview.videoController!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: ThemeApp.color.light,
              progressColors: ProgressBarColors(
                playedColor: ThemeApp.color.primary,
                handleColor: ThemeApp.color.primary,
              ),
              thumbnail: BlocBuilder<BlocLearningPreview, StateLearningPreview>(
                bloc: blocLearningPreview,
                builder: (context, state) {
                  final currentState = state as LearningPreviewLoaded;
                  return Image.network(
                    currentState.myCourse?.thumbnail ?? '',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image, size: 50, color: Colors.grey);
                    },
                  );
                },
              ),
              onReady: () {
                blocLearningPreview.loadVideo(blocLearningPreview.videoSources ?? "");
              },
            ),
            builder: (context, player) {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    if (blocLearningPreview.videoController?.value.isPlaying == true)
                      blocLearningPreview.videoController?.pause();
                  } else if (scrollNotification is ScrollEndNotification) {
                    // if (blocMain.videoController?.value.isPlaying == false) blocMain.videoController?.play();
                  }
                  return false;
                },
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      sliver: SliverAppBar(
                        backgroundColor: Colors.transparent,
                        expandedHeight: 90,
                        automaticallyImplyLeading: false,
                        surfaceTintColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => onPause(() {
                                  Navigator.of(context).pop();
                                }),
                                child: Transform.translate(
                                  offset: const Offset(-10, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
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
                                    child: BlocBuilder<BlocLearningPreview, StateLearningPreview>(
                                      bloc: blocLearningPreview,
                                      builder: (context, state) {
                                        final currentState = state as LearningPreviewLoaded;
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
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                      sliver: SliverPersistentHeader(
                        pinned: true,
                        delegate: HeaderSticky(
                          height: 230,
                          child: ColoredBox(
                            color: ThemeApp.color.dark,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: ThemeApp.color.secondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: BlocBuilder<BlocLearningPreview, StateLearningPreview>(
                                  bloc: blocLearningPreview,
                                  builder: (context, state) {
                                    final currentState = state as LearningPreviewLoaded;
                                    if (currentState.myCourse?.thumbnail == null ||
                                        currentState.myCourse?.thumbnail == '') {
                                      return Container(
                                        decoration: const BoxDecoration(),
                                        child: Center(
                                          child: Text(
                                            "Memuat data...",
                                            style: ThemeApp.font.semiBold.copyWith(color: ThemeApp.color.light),
                                          ),
                                        ),
                                      );
                                    }
                                    return player;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<BlocLearningPreview, StateLearningPreview>(
                      bloc: blocLearningPreview,
                      builder: (context, state) {
                        final currentState = state as LearningPreviewLoaded;
                        if ((currentState.myGroupLessons ?? []).isEmpty) {
                          return const Shimmer();
                        }
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          sliver: SliverList.builder(
                            itemCount: (currentState.myGroupLessons ?? []).length,
                            itemBuilder: (context, index) {
                              return DropdownTile(
                                title: (currentState.myGroupLessons ?? [])[index].title ?? '',
                                children: ((currentState.myGroupLessons ?? [])[index].lessons ?? [])
                                    .asMap()
                                    .entries
                                    .map((item) {
                                  return GestureDetector(
                                    onTap: () {
                                      item.value.source?.source == "external_url"
                                          ? Launcher.instance.open(
                                              Uri.parse(item.value.source?.sourceExternalUrl ?? ""),
                                            )
                                          : blocLearningPreview.loadVideo(
                                              blocLearningPreview.videoSources = item.value.source?.sourceYoutube ?? '',
                                              isLoading: true,
                                            );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: currentState.source == item.value.source?.sourceYoutube
                                            ? ThemeApp.color.white
                                            : ThemeApp.color.white.withOpacity(0.1),
                                        border: Border.all(width: 1, color: ThemeApp.color.white.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.value.title ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: ThemeApp.font.semiBold.copyWith(
                                                fontSize: 14,
                                                color: currentState.source == item.value.source?.sourceYoutube
                                                    ? ThemeApp.color.black
                                                    : ThemeApp.color.white,
                                              ),
                                            ),
                                          ),
                                          item.value.source?.source == "external_url"
                                              ? Icon(
                                                  Icons.chevron_right,
                                                  color: ThemeApp.color.white,
                                                )
                                              : Text(
                                                  item.value.source?.playtime ?? '',
                                                  style: ThemeApp.font.semiBold.copyWith(
                                                    fontSize: 14,
                                                    color: currentState.source == item.value.source?.sourceYoutube
                                                        ? ThemeApp.color.black
                                                        : ThemeApp.color.white,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Your Classes",
                                  style: ThemeApp.font.bold.copyWith(
                                    fontSize: 14,
                                    color: ThemeApp.color.white,
                                  ),
                                ),
                                Text(
                                  "See all",
                                  style: ThemeApp.font.regular.copyWith(
                                    fontSize: 12,
                                    color: ThemeApp.color.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<BlocLearningPreview, StateLearningPreview>(
                              bloc: blocLearningPreview,
                              builder: (context, state) {
                                final currentState = state as LearningPreviewLoaded;

                                if (currentState.myCourses == null) {
                                  return const ShimmerF2();
                                }
                                if ((currentState.myCourses ?? []).isEmpty) {
                                  return const NotFoundF2();
                                }

                                return SizedBox(
                                  height: 320, // biar pas dengan konten kartu
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(), // biar lebih halus
                                    itemCount: currentState.myCourses!.length,
                                    separatorBuilder: (context, _) => const SizedBox(width: 15),
                                    itemBuilder: (context, index) {
                                      final item = currentState.myCourses![index];
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
                                              height: 140,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.network(
                                                  item.thumbnail ?? "",
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return const Icon(
                                                      Icons.image,
                                                      size: 50,
                                                      color: Colors.grey,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              item.title ?? "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: ThemeApp.font.bold.copyWith(
                                                fontSize: 24,
                                                height: 1.2,
                                                color: ThemeApp.color.dark,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: ThemeApp.font.regular.copyWith(
                                                        color: ThemeApp.color.dark.withOpacity(0.5),
                                                      ),
                                                      children: [
                                                        const TextSpan(text: 'by '),
                                                        TextSpan(
                                                          text: item.authorName ?? "",
                                                          style: ThemeApp.font.semiBold,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(Asset.icUser),
                                                    const SizedBox(width: 3),
                                                    Text(
                                                      (item.enrolledCount ?? 0).toString(),
                                                      style: ThemeApp.font.semiBold.copyWith(
                                                        fontSize: 12,
                                                        color: ThemeApp.color.dark.withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Button(
                                                    onPress: () =>
                                                        blocLearningPreview.onGetDetailClass(courseId: item.id),
                                                    isBorder: false,
                                                    child: Text(
                                                      "Start Learning",
                                                      textAlign: TextAlign.center,
                                                      style: ThemeApp.font.medium.copyWith(
                                                        color: ThemeApp.color.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
