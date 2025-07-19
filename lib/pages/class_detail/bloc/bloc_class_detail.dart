import 'dart:convert';

import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/preview/model/model_preview.dart';
import 'package:csid_mobile/helpers/local_storage/local_storage.dart';
import 'package:csid_mobile/helpers/request/request_api.dart';
import 'package:csid_mobile/pages/class_detail/state/state_class_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocClassDetail extends Cubit<StateClassDetail> {
  BlocClassDetail({this.arguments}) : super(ClassDetailInitial());

  final String? arguments;

  void initialPage() {
    emit(ClassDetailLoaded());
    final currentState = state as ClassDetailLoaded;
    LocalStorage.instance.getAuth().then((res) {
      emit(currentState.copyWith(auth: res, courseId: (jsonDecode(arguments ?? ''))['course_id']));
      onGetClass();
    });
  }

  Future<void> onGetClass() async {
    final currentState = state as ClassDetailLoaded;
    await RequestApi()
        .get(path: "course-detail?course_id=${currentState.courseId}", isLoading: false)
        .then((res) async {
      if ([200, 201].contains(res.statusCode)) {
        final raw = jsonDecode(res.body)['data'];
        ModelCourse? course;
        course = ModelCourse.fromJson(raw);

        ModelPreview? previews = await onGetPreviewByClass(courseId: currentState.courseId);

        emit(currentState.copyWith(
          course: course,
          previews: previews,
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
  void onChange(Change<StateClassDetail> change) {
    super.onChange(change);
  }
}
