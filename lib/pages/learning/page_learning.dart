import 'package:csid_mobile/helpers/formatter/formatter_price.dart';
import 'package:csid_mobile/pages/learning/widget/not_found.dart';
import 'package:csid_mobile/pages/learning/widget/shimmer.dart';
import 'package:csid_mobile/pages/main/bloc/bloc_main.dart';
import 'package:csid_mobile/pages/main/state/state_main.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageLearning extends StatefulWidget {
  const PageLearning({super.key});

  @override
  State<PageLearning> createState() => _PageLearningState();
}

class _PageLearningState extends State<PageLearning> {
  final ScrollController _scrollController = ScrollController();
  late BlocMain blocMain;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    blocMain = context.read<BlocMain>();
    blocMain.onGetAllClass();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !isLoadingMore) {
        blocMain.onGetAllClass();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => blocMain.pageController?.jumpToPage(0),
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
            GestureDetector(
              onTap: () => blocMain.pageController?.jumpToPage(2),
              child: Container(
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
                    child: BlocBuilder<BlocMain, StateMain>(
                      bloc: blocMain,
                      builder: (context, state) {
                        final currentState = state as MainLoaded;
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
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "All Classes",
              style: ThemeApp.font.bold.copyWith(fontSize: 14, color: ThemeApp.color.white),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<BlocMain, StateMain>(
          bloc: blocMain,
          builder: (context, state) {
            final currentState = state as MainLoaded;
            if ((currentState.allCourses) == null) {
              return const ShimmerF3();
            } else if ((currentState.allCourses ?? []).isEmpty) {
              return const NotFound();
            }
            return StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: (currentState.allCourses ?? []).asMap().entries.map((item) {
                return StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1.25,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ThemeApp.color.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.value.thumbnail ?? "",
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image, size: 50, color: Colors.grey);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          item.value.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: ThemeApp.font.bold.copyWith(
                            fontSize: 14,
                            height: 1.2,
                            color: ThemeApp.color.dark,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: ThemeApp.font.regular.copyWith(
                                    fontSize: 10,
                                    color: ThemeApp.color.dark.withOpacity(0.5),
                                  ),
                                  children: [
                                    const TextSpan(text: 'by '),
                                    TextSpan(text: item.value.authorName ?? "", style: ThemeApp.font.semiBold),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Asset.icUser,
                                  width: 10,
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  (item.value.enrolledCount ?? 0).toString(),
                                  style: ThemeApp.font.semiBold.copyWith(
                                    fontSize: 10,
                                    color: ThemeApp.color.dark.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          children: [
                            item.value.currentUserEnrolled == false
                                ? Text(
                                    "Rp.${FormatterPrice.instance.formatToK((item.value.salePrice ?? 0))}",
                                    style: ThemeApp.font.semiBold,
                                  )
                                : Container(),
                            item.value.currentUserEnrolled == false
                                ? const SizedBox(
                                    width: 5,
                                  )
                                : Container(),
                            Expanded(
                              child: Button(
                                onPress: () => blocMain.redirectToForClass(
                                  context,
                                  courseId: item.value.id,
                                  enrolled: item.value.currentUserEnrolled,
                                ),
                                isBorder: false,
                                colors: item.value.currentUserEnrolled == false
                                    ? const [
                                        Color.fromRGBO(238, 73, 69, 1),
                                        Color.fromRGBO(255, 219, 141, 1),
                                      ]
                                    : null,
                                child: Text(
                                  item.value.currentUserEnrolled == false ? "See Detail" : "Start Learning",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: ThemeApp.font.medium.copyWith(color: ThemeApp.color.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
