import 'package:csid_mobile/database/auth/model/model_login.dart';
import 'package:csid_mobile/database/course/model/model_course.dart';

abstract class StateLearning {}

class LearningInitial extends StateLearning {}

class LearningLoading extends StateLearning {}

class LearningLoaded extends StateLearning {
  final List<ModelCourse>? courses;

  LearningLoaded({this.courses});

  LearningLoaded copyWith({
    ModelLogin? auth,
    int? member,
    int? course,
    List<ModelCourse>? courses,
  }) {
    return LearningLoaded(
      courses: courses ?? this.courses,
    );
  }
}

class LearningError extends StateLearning {
  final String message;

  LearningError(this.message);
}
