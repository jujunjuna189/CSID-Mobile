import 'package:csid_mobile/database/auth/model/model_login.dart';
import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/lesson/model/model_group_lesson.dart';
import 'package:csid_mobile/database/lesson/model/model_lesson.dart';
import 'package:csid_mobile/database/preview/model/model_preview.dart';

abstract class StateLearningPreview {}

class LearningPreviewInitial extends StateLearningPreview {}

class LearningPreviewLoading extends StateLearningPreview {}

class LearningPreviewLoaded extends StateLearningPreview {
  final ModelLogin? auth;
  final int? courseId;
  final String? source;
  final List<ModelCourse>? myCourses;
  final ModelCourse? myCourse;
  final ModelPreview? myPreviews;
  final List<ModelLesson>? myLessons;
  final List<ModelGroupLesson>? myGroupLessons;

  LearningPreviewLoaded(
      {this.auth,
      this.source,
      this.courseId,
      this.myCourses,
      this.myCourse,
      this.myPreviews,
      this.myLessons,
      this.myGroupLessons});

  LearningPreviewLoaded copyWith({
    ModelLogin? auth,
    String? source,
    int? courseId,
    List<ModelCourse>? myCourses,
    ModelCourse? myCourse,
    ModelPreview? myPreviews,
    List<ModelLesson>? myLessons,
    List<ModelGroupLesson>? myGroupLessons,
  }) {
    return LearningPreviewLoaded(
      auth: auth ?? this.auth,
      source: source ?? this.source,
      courseId: courseId ?? this.courseId,
      myCourses: myCourses ?? this.myCourses,
      myCourse: myCourse ?? this.myCourse,
      myPreviews: myPreviews ?? this.myPreviews,
      myLessons: myLessons ?? this.myLessons,
      myGroupLessons: myGroupLessons ?? this.myGroupLessons,
    );
  }
}

class LearningPreviewError extends StateLearningPreview {
  final String message;

  LearningPreviewError(this.message);
}
