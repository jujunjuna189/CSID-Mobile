import 'dart:convert';

import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/payment/model/model_invoice.dart';
import 'package:csid_mobile/helpers/local_storage/local_storage.dart';
import 'package:csid_mobile/helpers/request/request_api.dart';
import 'package:csid_mobile/pages/payment/state/state_payment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPayment extends Cubit<StatePayment> {
  BlocPayment({this.arguments}) : super(PaymentInitial());
  final String? arguments;

  void initialPage() {
    emit(PaymentLoaded());
    final currentState = state as PaymentLoaded;
    LocalStorage.instance.getAuth().then((res) {
      emit(currentState.copyWith(
        auth: res,
        courseId: (jsonDecode(arguments ?? ''))['course_id'],
        method: (jsonDecode(arguments ?? ''))['method'],
        methodIcon: (jsonDecode(arguments ?? ''))['method_icon'],
        methodGroup: (jsonDecode(arguments ?? ''))['method_group'],
      ));
      onGetClass().then((res) {
        onCreateInvoice();
      });
    });
  }

  Future<void> onGetClass() async {
    final currentState = state as PaymentLoaded;
    await RequestApi().get(path: "course-detail?course_id=${currentState.courseId}").then((res) async {
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

  Future<void> onCreateInvoice() async {
    final currentState = state as PaymentLoaded;
    Map<String, String> dataBatch = {
      "method": currentState.method ?? "",
      "user_id": (currentState.auth?.id ?? "").toString(),
      "course_id": (currentState.courseId ?? 0).toString(),
      "amount": (currentState.course?.salePrice ?? 0).toString(),
    };

    if (currentState.methodGroup == 'E-Wallet') dataBatch.addAll({"customer_phone": currentState.auth?.phone ?? ""});
    RequestApi().post(path: "create-invoice", body: dataBatch).then((res) async {
      if ([200, 201].contains(res.statusCode)) {
        final raw = jsonDecode(res.body)['invoice']['data'];
        ModelInvoice? invoice;
        invoice = ModelInvoice.fromJson(raw);
        emit(currentState.copyWith(
          invoice: invoice,
        ));
      }
    });
  }

  @override
  void onChange(Change<StatePayment> change) {
    super.onChange(change);
  }
}
