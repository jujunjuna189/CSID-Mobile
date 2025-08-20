import 'package:csid_mobile/helpers/launcher/launcher.dart';
import 'package:csid_mobile/pages/learning_preview/bloc/bloc_learning_preview.dart';
import 'package:csid_mobile/pages/learning_preview/state/state_learning_preview.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupLesson extends StatefulWidget {
  const PopupLesson({super.key});

  @override
  State<PopupLesson> createState() => _PopupLessonState();
}

class _PopupLessonState extends State<PopupLesson> {
  late BlocLearningPreview blocLearningPreview;
  bool isOpen = false;

  @override
  void initState() {
    blocLearningPreview = context.read<BlocLearningPreview>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Popup panel geser dari kanan
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: 0,
          bottom: 0,
          right: isOpen ? 0 : -screenWidth / 2,
          child: Container(
            width: screenWidth / 2,
            height: double.infinity,
            decoration: BoxDecoration(
              color: ThemeApp.color.white,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
              border: Border.all(
                width: 1,
                color: ThemeApp.color.white.withOpacity(0.2),
              ),
              gradient: RadialGradient(
                colors: [ThemeApp.color.light, ThemeApp.color.primary, ThemeApp.color.secondary, ThemeApp.color.dark],
                center: const Alignment(0, 1),
                radius: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 10),
                  child: Text(
                    "Class Curriculum",
                    style: TextStyle(
                      color: ThemeApp.color.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<BlocLearningPreview, StateLearningPreview>(
                    bloc: blocLearningPreview,
                    builder: (context, state) {
                      final currentState = state as LearningPreviewLoaded;
                      if ((currentState.myLessons ?? []).isEmpty) {
                        return Center(
                          child: Text(
                            "This is the content area",
                            style: TextStyle(
                              color: ThemeApp.color.black,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemCount: (currentState.myLessons ?? []).length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              (currentState.myLessons ?? [])[index].source?.source == "external_url"
                                  ? Launcher.instance.open(
                                      Uri.parse((currentState.myLessons ?? [])[index].source?.sourceExternalUrl ?? ""),
                                    )
                                  : blocLearningPreview.loadVideo(
                                      blocLearningPreview.videoSources =
                                          (currentState.myLessons ?? [])[index].source?.sourceYoutube ?? '',
                                      isLoading: true,
                                    );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color:
                                    currentState.source == (currentState.myLessons ?? [])[index].source?.sourceYoutube
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
                                      (currentState.myLessons ?? [])[index].title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: ThemeApp.font.semiBold.copyWith(
                                        fontSize: 14,
                                        color: currentState.source ==
                                                (currentState.myLessons ?? [])[index].source?.sourceYoutube
                                            ? ThemeApp.color.black
                                            : ThemeApp.color.white,
                                      ),
                                    ),
                                  ),
                                  (currentState.myLessons ?? [])[index].source?.source == "external_url"
                                      ? Icon(
                                          Icons.chevron_right,
                                          color: ThemeApp.color.white,
                                        )
                                      : Text(
                                          (currentState.myLessons ?? [])[index].source?.playtime ?? '',
                                          style: ThemeApp.font.semiBold.copyWith(
                                            fontSize: 14,
                                            color: currentState.source ==
                                                    (currentState.myLessons ?? [])[index].source?.sourceYoutube
                                                ? ThemeApp.color.black
                                                : ThemeApp.color.white,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),

        // Floating button di pojok kanan atas
        Positioned(
          top: 20,
          right: 20,
          child: BlocBuilder<BlocLearningPreview, StateLearningPreview>(
            bloc: blocLearningPreview,
            builder: (context, state) {
              final currentState = state as LearningPreviewLoaded;
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  blocLearningPreview.onGetLessonByClass(courseId: currentState.courseId);
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: Transform.translate(
                  offset: const Offset(15, -15),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: isOpen ? ThemeApp.color.white.withOpacity(0.2) : ThemeApp.color.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        isOpen ? Icons.close : Icons.add,
                        color: ThemeApp.color.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
