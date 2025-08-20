import 'dart:convert';

import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/lesson/model/model_group_lesson.dart';
import 'package:csid_mobile/database/lesson/model/model_lesson.dart';
import 'package:csid_mobile/database/preview/model/model_preview.dart';
import 'package:csid_mobile/helpers/local_storage/local_storage.dart';
import 'package:csid_mobile/helpers/request/request_api.dart';
import 'package:csid_mobile/pages/learning_preview/state/state_learning_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BlocLearningPreview extends Cubit<StateLearningPreview> {
  BlocLearningPreview({this.arguments}) : super(LearningPreviewInitial());

  final String? arguments;
  String? videoSources;
  YoutubePlayerController? videoController;

  void initialPage() {
    emit(LearningPreviewLoaded());
    final currentState = state as LearningPreviewLoaded;
    LocalStorage.instance.getAuth().then((res) {
      emit(currentState.copyWith(auth: res, courseId: (jsonDecode(arguments ?? ''))['course_id']));
      onGetDetailClass().then((res) {
        onGetMyClass();
      });
    });
  }

  // SetVideoPreview
  void loadVideo(String source, {bool isLoading = false, bool isInitial = false}) {
    if (source == "") return;
    final currentState = state as LearningPreviewLoaded;
    if (isLoading) EasyLoading.show();
    videoSources = source;
    String newId = YoutubePlayer.convertUrlToId(source)!;
    videoController?.load(newId, startAt: 0);
    Future.delayed(const Duration(milliseconds: 500), () {
      EasyLoading.dismiss();
      Future.delayed(const Duration(milliseconds: 500), () {
        if (isInitial == false) emit(currentState.copyWith(source: source));
      });
    });
    // videoController?.pause();
  }

  Future onGetDetailClass({int? courseId}) async {
    EasyLoading.show();
    final currentState = state as LearningPreviewLoaded;
    await RequestApi()
        .get(path: "course-detail?course_id=${courseId ?? currentState.courseId}", isLoading: false)
        .then((res) async {
      if ([200, 201].contains(res.statusCode)) {
        final raw = jsonDecode(res.body)['data'];
        ModelCourse course = ModelCourse.fromJson(raw);
        ModelPreview? previews = await onGetPreviewByClass(courseId: courseId ?? currentState.courseId);
        List<ModelGroupLesson>? groupLessons = await onGetGroupLessonByClass(
          courseId: courseId ?? currentState.courseId,
        );

        loadVideo(previews?.metaValue?.first.youtubeUrl ?? "", isLoading: false, isInitial: true);
        EasyLoading.dismiss();
        emit(currentState.copyWith(
          myCourse: course,
          myPreviews: previews,
          myGroupLessons: groupLessons,
        ));
      }
    });
  }

  Future<ModelPreview?> onGetPreviewByClass({int? courseId}) async {
    return await RequestApi().get(path: "course-previews?course_id=$courseId", isLoading: false).then((res) {
      ModelPreview previews;
      if ([200, 201].contains(res.statusCode)) {
        final raw = jsonDecode(res.body)['data'];

        previews = ModelPreview.fromJson(raw);

        return previews;
      } else {
        return null;
      }
    });
  }

  Future<List<ModelGroupLesson>?> onGetGroupLessonByClass({int? courseId}) async {
    return await RequestApi().get(path: "course-group-lessons?course_id=$courseId", isLoading: false).then((res) {
      List<ModelGroupLesson> groupLessons = [];
      if ([200, 201].contains(res.statusCode)) {
        List raw = jsonDecode(res.body)['data'] as List;
        groupLessons.addAll(raw.map((e) => ModelGroupLesson.fromJson(e)).toList());

        return groupLessons;
      } else {
        return null;
      }
    });
  }

  Future onGetLessonByClass({int? courseId}) async {
    final currentState = state as LearningPreviewLoaded;
    if ((currentState.myLessons ?? []).isNotEmpty) return;
    return await RequestApi().get(path: "course-lessons?course_id=$courseId").then((res) {
      List<ModelLesson> lessons = [];
      if ([200, 201].contains(res.statusCode)) {
        List raw = jsonDecode(res.body)['data'] as List;
        lessons.addAll(raw.map((e) => ModelLesson.fromJson(e)).toList());

        emit(currentState.copyWith(
          myLessons: lessons,
        ));
      }
    });
  }

  Future onGetMyClass() async {
    final currentState = state as LearningPreviewLoaded;
    if (currentState.myCourses != null && currentState.myCourses!.isNotEmpty) return;
    await RequestApi().get(path: "my-courses?user_id=${currentState.auth?.id}", isLoading: false).then((res) async {
      if ([200, 201].contains(res.statusCode)) {
        List raw = jsonDecode(res.body)['data'] as List;
        List<ModelCourse> courses = [];
        courses.addAll(raw.map((e) => ModelCourse.fromJson(e)).toList());

        emit(currentState.copyWith(
          myCourses: courses,
        ));
      }
    });
  }

  @override
  void onChange(Change<StateLearningPreview> change) {
    super.onChange(change);
  }
}
