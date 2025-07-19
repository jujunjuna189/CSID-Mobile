import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:csid_mobile/pages/main/bloc/bloc_main.dart';
import 'package:csid_mobile/pages/main/state/state_main.dart';
import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    BlocMain blocMain = context.read<BlocMain>();

    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<BlocMain, StateMain>(
                        bloc: blocMain,
                        builder: (context, state) {
                          final currentState = state as MainLoaded;
                          return RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              children: [
                                const TextSpan(text: "Hello,"),
                                TextSpan(text: currentState.auth?.displayName ?? "", style: ThemeApp.font.semiBold),
                              ],
                            ),
                          );
                        },
                      ),
                      Text(
                        "Welcome Back !",
                        style: ThemeApp.font.regular.copyWith(color: ThemeApp.color.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: ThemeApp.color.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                Asset.icNotification,
                width: 19,
                height: 19,
                color: ThemeApp.color.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 194.0,
            autoPlay: true,
            viewportFraction: 1.0,
          ),
          items: [1, 2, 3, 4, 5].map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: ThemeApp.color.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        Asset.imgBanner1,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            },
          ).toList(),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ThemeApp.color.white.withOpacity(0.1),
            border: Border.all(width: 1, color: ThemeApp.color.white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Member",
                      style: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
                    ),
                    BlocBuilder<BlocMain, StateMain>(
                      bloc: blocMain,
                      builder: (context, state) {
                        final currentState = state as MainLoaded;
                        return Text(
                          (currentState.member ?? '-').toString(),
                          style: ThemeApp.font.bold.copyWith(fontSize: 24, color: ThemeApp.color.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: VerticalDivider(
                  color: ThemeApp.color.white.withOpacity(0.8),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Classes",
                      style: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
                    ),
                    BlocBuilder<BlocMain, StateMain>(
                      bloc: blocMain,
                      builder: (context, state) {
                        final currentState = state as MainLoaded;
                        return Text(
                          (currentState.course ?? '-').toString(),
                          style: ThemeApp.font.bold.copyWith(fontSize: 24, color: ThemeApp.color.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "CSID Classes",
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
                children: (currentState.courses ?? []).asMap().entries.map((item) {
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
                                onPress: () => Navigator.of(context).pushNamed(
                                  RouteName.CLASS_DETAIL,
                                  arguments: jsonEncode(
                                    {'course_id': item.value.id},
                                  ),
                                ),
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
