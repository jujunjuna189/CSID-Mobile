import 'package:csid_mobile/database/auth/model/model_login.dart';
import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/slider/model/model_slider.dart';

abstract class StateMain {}

class MainInitial extends StateMain {}

class MainLoading extends StateMain {}

class MainLoaded extends StateMain {
  final ModelLogin? auth;
  final List<ModelSlider>? slider;
  final int? member;
  final int? course;
  final List<ModelCourse>? courses;
  final int? limitAllCourse;
  final List<ModelCourse>? allCourses;
  final List<ModelCourse>? myCourses;
  final ModelCourse? myCourse;

  MainLoaded({
    this.auth,
    this.slider,
    this.member,
    this.course,
    this.courses,
    this.limitAllCourse,
    this.allCourses,
    this.myCourses,
    this.myCourse,
  });

  MainLoaded copyWith({
    ModelLogin? auth,
    List<ModelSlider>? slider,
    int? member,
    int? course,
    List<ModelCourse>? courses,
    int? limitAllCourse,
    List<ModelCourse>? allCourses,
    List<ModelCourse>? myCourses,
    ModelCourse? myCourse,
  }) {
    return MainLoaded(
      auth: auth ?? this.auth,
      slider: slider ?? this.slider,
      member: member ?? this.member,
      course: course ?? this.course,
      courses: courses ?? this.courses,
      limitAllCourse: limitAllCourse ?? this.limitAllCourse,
      allCourses: allCourses ?? this.allCourses,
      myCourses: myCourses ?? this.myCourses,
      myCourse: myCourse ?? this.myCourse,
    );
  }
}

class MainError extends StateMain {
  final String message;

  MainError(this.message);
}
