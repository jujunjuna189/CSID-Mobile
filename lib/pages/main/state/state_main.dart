import 'package:csid_mobile/database/auth/model/model_login.dart';
import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/lesson/model/model_lesson.dart';
import 'package:csid_mobile/database/preview/model/model_preview.dart';

abstract class StateMain {}

class MainInitial extends StateMain {}

class MainLoading extends StateMain {}

class MainLoaded extends StateMain {
  final ModelLogin? auth;
  final int? member;
  final int? course;
  final List<ModelCourse>? courses;
  final List<ModelCourse>? myCourses;
  final ModelCourse? myCourse;
  final ModelPreview? myPreviews;
  final List<ModelLesson>? myLessons;

  MainLoaded(
      {this.auth,
      this.member,
      this.course,
      this.courses,
      this.myCourses,
      this.myCourse,
      this.myPreviews,
      this.myLessons});

  MainLoaded copyWith({
    ModelLogin? auth,
    int? member,
    int? course,
    List<ModelCourse>? courses,
    List<ModelCourse>? myCourses,
    ModelCourse? myCourse,
    ModelPreview? myPreviews,
    List<ModelLesson>? myLessons,
  }) {
    return MainLoaded(
      auth: auth ?? this.auth,
      member: member ?? this.member,
      course: course ?? this.course,
      courses: courses ?? this.courses,
      myCourses: myCourses ?? this.myCourses,
      myCourse: myCourse ?? this.myCourse,
      myPreviews: myPreviews ?? this.myPreviews,
      myLessons: myLessons ?? this.myLessons,
    );
  }
}

class MainError extends StateMain {
  final String message;

  MainError(this.message);
}
