import 'package:csid_mobile/pages/main/state/state_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csid_mobile/pages/main/bloc/bloc_main.dart';
import 'package:csid_mobile/pages/profile/widget/card/card_profile.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageProfile extends StatelessWidget {
  const PageProfile({super.key});

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
            Container(
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
            const SizedBox(
              height: 64,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const CardProfile(),
        const SizedBox(
          height: 30,
        ),
        BlocBuilder<BlocMain, StateMain>(
          bloc: blocMain,
          builder: (context, state) {
            final currentState = state as MainLoaded;
            return Text(
              currentState.auth?.displayName ?? '-',
              textAlign: TextAlign.center,
              style: ThemeApp.font.medium.copyWith(fontSize: 20, color: ThemeApp.color.white),
            );
          },
        ),
        Text(
          "CSID Member",
          textAlign: TextAlign.center,
          style: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: ThemeApp.color.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Username ",
                  style: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
                ),
              ),
              BlocBuilder<BlocMain, StateMain>(
                bloc: blocMain,
                builder: (context, state) {
                  final currentState = state as MainLoaded;
                  return Expanded(
                    flex: 4,
                    child: Text(
                      ": ${currentState.auth?.username ?? '-'}",
                      style: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: ThemeApp.color.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Email ",
                  style: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
                ),
              ),
              BlocBuilder<BlocMain, StateMain>(
                bloc: blocMain,
                builder: (context, state) {
                  final currentState = state as MainLoaded;
                  return Expanded(
                    flex: 4,
                    child: Text(
                      ": ${currentState.auth?.email ?? '-'}",
                      style: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: ThemeApp.color.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "No Hp ",
                  style: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
                ),
              ),
              BlocBuilder<BlocMain, StateMain>(
                bloc: blocMain,
                builder: (context, state) {
                  final currentState = state as MainLoaded;
                  return Expanded(
                    flex: 4,
                    child: Text(
                      ": ${currentState.auth?.phone ?? '-'}",
                      style: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: ThemeApp.color.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
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
