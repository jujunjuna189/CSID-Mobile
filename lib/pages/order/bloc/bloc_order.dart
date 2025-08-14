import 'dart:convert';

import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/payment_channel/model/model_payment_channel.dart';
import 'package:csid_mobile/helpers/local_storage/local_storage.dart';
import 'package:csid_mobile/helpers/request/request_api.dart';
import 'package:csid_mobile/pages/order/state/state_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocOrder extends Cubit<StateOrder> {
  BlocOrder({this.arguments}) : super(OrderInitial());

  final String? arguments;

  void initialPage() {
    emit(OrderLoaded());
    final currentState = state as OrderLoaded;
    LocalStorage.instance.getAuth().then((res) {
      emit(currentState.copyWith(auth: res, courseId: (jsonDecode(arguments ?? ''))['course_id']));
      onGetClass().then((res) {
        onGetMethode();
      });
    });
  }

  Future<void> onGetClass() async {
    final currentState = state as OrderLoaded;
    await RequestApi()
        .get(path: "course-detail?course_id=${currentState.courseId}", isLoading: false)
        .then((res) async {
      if ([200, 201].contains(res.statusCode)) {
        final raw = jsonDecode(res.body)['data'];
        ModelCourse? course;
        course = ModelCourse.fromJson(raw);

        emit(currentState.copyWith(
          course: course,
        ));
      }
    });
  }

  void onGetMethode() {
    final currentState = state as OrderLoaded;
    RequestApi().get(path: "payment-channel").then((res) {
      if ([200, 201].contains(res.statusCode)) {
        List raw = jsonDecode(res.body)['data'] as List;
        List<ModelPaymentChannel> paymentChannels = [];
        paymentChannels.addAll(raw.map((e) => ModelPaymentChannel.fromJson(e)).toList());

        emit(currentState.copyWith(
          paymentChannels: paymentChannels,
        ));
      }
    });
  }

  @override
  void onChange(Change<StateOrder> change) {
    super.onChange(change);
  }
}
