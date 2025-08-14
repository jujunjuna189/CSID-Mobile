import 'package:csid_mobile/database/auth/model/model_login.dart';
import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/payment/model/model_invoice.dart';

abstract class StatePayment {}

class PaymentInitial extends StatePayment {}

class PaymentLoading extends StatePayment {}

class PaymentLoaded extends StatePayment {
  final ModelLogin? auth;
  final int? courseId;
  final String? method;
  final String? methodIcon;
  final ModelCourse? course;
  final ModelInvoice? invoice;

  PaymentLoaded({this.auth, this.courseId, this.method, this.methodIcon, this.course, this.invoice});

  PaymentLoaded copyWith({
    ModelLogin? auth,
    int? courseId,
    String? method,
    String? methodIcon,
    ModelCourse? course,
    ModelInvoice? invoice,
  }) {
    return PaymentLoaded(
      auth: auth ?? this.auth,
      courseId: courseId ?? this.courseId,
      method: method ?? this.method,
      methodIcon: methodIcon ?? this.methodIcon,
      course: course ?? this.course,
      invoice: invoice ?? this.invoice,
    );
  }
}

class PaymentError extends StatePayment {
  final String message;

  PaymentError(this.message);
}
