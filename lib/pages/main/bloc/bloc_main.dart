import 'dart:convert';
import 'package:csid_mobile/database/slider/model/model_slider.dart';
import 'package:csid_mobile/helpers/local_storage/local_storage.dart';
import 'package:csid_mobile/helpers/request/request_api.dart';
import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/pages/main/state/state_main.dart';
import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/widgets/molecules/modal/modal_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      onGetSlider().then((res) {
        onGetSummary().then((res) {
          onGetMyClass().then((res) {
            onGetClass();
          });
        });
      });
    });
  }

  Future<void> onGetSlider() async {
    final currentState = state as MainLoaded;
    await RequestApi().get(path: "slider", isLoading: false).then((res) {
      if ([200, 201].contains(res.statusCode)) {
        List raw = jsonDecode(res.body)['data'] as List;
        List<ModelSlider> slider = [];
        slider.addAll(raw.map((e) => ModelSlider.fromJson(e)).toList());

        emit(currentState.copyWith(
          slider: slider,
        ));
      }
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
    RequestApi().get(path: "course?user_id=${currentState.auth?.id}&limit=5", isLoading: false).then((res) {
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

  void onGetAllClass() {
    final currentState = state as MainLoaded;
    RequestApi().get(path: "course?user_id=${currentState.auth?.id}&limit=10", isLoading: false).then((res) {
      if ([200, 201].contains(res.statusCode)) {
        List raw = jsonDecode(res.body)['data'] as List;
        List<ModelCourse> allCourses = [];
        allCourses.addAll(raw.map((e) => ModelCourse.fromJson(e)).toList());

        emit(currentState.copyWith(
          allCourses: allCourses,
        ));
      }
    });
  }

  Future onGetMyClass() async {
    final currentState = state as MainLoaded;
    if (currentState.myCourses != null && currentState.myCourses!.isNotEmpty) return;
    await RequestApi().get(path: "my-courses?user_id=${currentState.auth?.id}", isLoading: false).then((res) async {
      if ([200, 201].contains(res.statusCode)) {
        List raw = jsonDecode(res.body)['data'] as List;
        List<ModelCourse> courses = [];
        courses.addAll(raw.map((e) => ModelCourse.fromJson(e)).toList());

        emit(currentState.copyWith(
          myCourses: courses,
          myCourse: courses.isNotEmpty ? courses.first : null,
        ));
      }
    });
  }

  Future onGetDetailMyClass({required String courseId}) async {
    final currentState = state as MainLoaded;
    EasyLoading.show();
    ModelCourse myCourse = (currentState.myCourses ?? []).firstWhere((item) => item.id.toString() == courseId);

    EasyLoading.dismiss();
    emit(currentState.copyWith(
      myCourse: myCourse,
    ));
  }

  Future onLogout(BuildContext context) async {
    ModalMessage.show(
      context,
      title: "Log out Confirmation",
      message: 'Are you sure you want to log out from this account?',
      secondaryText: "Back",
      confirmText: "Log Out",
      onConfirm: () async {
        await LocalStorage.instance.clearAuth().then((res) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!context.mounted) return;
            Navigator.of(context).pushNamedAndRemoveUntil(RouteName.LOGIN, (route) => false);
          });
        });
      },
    );
  }

  @override
  void onChange(Change<StateMain> change) {
    super.onChange(change);
  }
}
