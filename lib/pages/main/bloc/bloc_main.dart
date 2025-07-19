import 'dart:convert';

import 'package:csid_mobile/database/preview/model/model_preview.dart';
import 'package:csid_mobile/helpers/local_storage/local_storage.dart';
import 'package:csid_mobile/helpers/request/request_api.dart';
import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/pages/main/state/state_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocMain extends Cubit<StateMain> {
  BlocMain() : super(MainInitial());

  late PageController pageController;

  void initialPage() {
    emit(MainLoaded());
    final currentState = state as MainLoaded;
    LocalStorage.instance.getAuth().then((res) {
      emit(currentState.copyWith(
        auth: res,
      ));
      onGetSummary().then((res) {
        onGetClass();
      });
    });
  }

  Future<void> onGetSummary() async {
    final currentState = state as MainLoaded;
    await RequestApi().get(path: "summary", isLoading: false).then((res) {
      if ([200, 201].contains(res.statusCode)) {
        final raw = jsonDecode(res.body)['data'];

        emit(currentState.copyWith(
          member: raw['total_members'] is! int ? int.parse((raw['total_members'] ?? '0')) : raw['total_members'],
          course: raw['total_courses'] is! int ? int.parse((raw['total_courses'] ?? '0')) : raw['total_courses'],
        ));
      }
    });
  }

  void onGetClass() {
    final currentState = state as MainLoaded;
    RequestApi().get(path: "course?limit=5", isLoading: false).then((res) {
      if ([200, 201].contains(res.statusCode)) {
        List raw = jsonDecode(res.body)['data'] as List;
        List<ModelCourse> courses = [];
        courses.addAll(raw.map((e) => ModelCourse.fromJson(e)).toList());

        emit(currentState.copyWith(
          courses: courses,
        ));
      }
    });
  }

  void onGetMyClass() {
    final currentState = state as MainLoaded;
    if (currentState.myCourses != null && currentState.myCourses!.isNotEmpty) return;
    RequestApi().get(path: "my-courses?user_id=${currentState.auth?.id}", isLoading: false).then((res) async {
      if ([200, 201].contains(res.statusCode)) {
        List raw = jsonDecode(res.body)['data'] as List;
        List<ModelCourse> courses = [];
        courses.addAll(raw.map((e) => ModelCourse.fromJson(e)).toList());

        ModelPreview? previews = await onGetPreviewByClass(courseId: courses.first.id);

        emit(currentState.copyWith(
          myCourses: courses,
          myCourse: courses.first,
          myPreviews: previews,
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

  @override
  void onChange(Change<StateMain> change) {
    super.onChange(change);
  }
}
