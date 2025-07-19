import 'package:csid_mobile/pages/main/state/state_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csid_mobile/pages/main/bloc/bloc_main.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageLearning extends StatelessWidget {
  const PageLearning({super.key});

  @override
  Widget build(BuildContext context) {
    BlocMain blocMain = context.read<BlocMain>();
    blocMain.onGetMyClass();

    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => blocMain.pageController.jumpToPage(0),
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
          child: BlocBuilder<BlocMain, StateMain>(
            bloc: blocMain,
            builder: (context, state) {
              final currentState = state as MainLoaded;
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  currentState.myCourse?.thumbnail ?? '',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image, size: 50, color: Colors.grey);
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<BlocMain, StateMain>(
          bloc: blocMain,
          builder: (context, state) {
            final currentState = state as MainLoaded;
            return Column(
              children: (currentState.myPreviews?.metaValue ?? []).asMap().entries.map((item) {
                return Container(
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
                      Text(
                        item.value.title ?? '',
                        style: ThemeApp.font.semiBold.copyWith(fontSize: 14, color: ThemeApp.color.white),
                      ),
                      Text(
                        item.value.duration ?? '',
                        style: ThemeApp.font.semiBold.copyWith(fontSize: 14, color: ThemeApp.color.white),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your Classes",
              style: ThemeApp.font.bold.copyWith(fontSize: 14, color: ThemeApp.color.white),
            ),
            Text(
              "See all",
              style: ThemeApp.font.regular.copyWith(fontSize: 12, color: ThemeApp.color.white),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocBuilder<BlocMain, StateMain>(
            bloc: blocMain,
            builder: (context, state) {
              final currentState = state as MainLoaded;
              return Row(
                children: (currentState.myCourses ?? []).asMap().entries.map((item) {
                  return Container(
                    margin: EdgeInsets.only(left: item.key == 0 ? 0 : 15),
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
                            fontSize: 24,
                            height: 1.2,
                            color: ThemeApp.color.dark,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                                    TextSpan(text: item.value.authorName ?? "", style: ThemeApp.font.semiBold),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(Asset.icUser),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  (item.value.enrolledCount ?? 0).toString(),
                                  style: ThemeApp.font.semiBold.copyWith(
                                    fontSize: 12,
                                    color: ThemeApp.color.dark.withOpacity(0.5),
                                  ),
                                ),
                              ],
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
                                onPress: () => blocMain.pageController.jumpToPage(1),
                                child: Text(
                                  "Start Learning",
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
                }).toList(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
