import 'package:csid_mobile/database/auth/model/model_login.dart';
import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/preview/model/model_preview.dart';

abstract class StateClassDetail {}

class ClassDetailInitial extends StateClassDetail {}

class ClassDetailLoading extends StateClassDetail {}

class ClassDetailLoaded extends StateClassDetail {
  final ModelLogin? auth;
  final int? courseId;
  final ModelCourse? course;
  final ModelPreview? previews;

  ClassDetailLoaded({this.auth, this.courseId, this.course, this.previews});

  ClassDetailLoaded copyWith({
    ModelLogin? auth,
    int? courseId,
    ModelCourse? course,
    ModelPreview? previews,
  }) {
    return ClassDetailLoaded(
      auth: auth ?? this.auth,
      courseId: courseId ?? this.courseId,
      course: course ?? this.course,
      previews: previews ?? this.previews,
    );
  }
}

class ClassDetailError extends StateClassDetail {
  final String message;

  ClassDetailError(this.message);
}
