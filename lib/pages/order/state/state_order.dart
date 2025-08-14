import 'package:csid_mobile/database/auth/model/model_login.dart';
import 'package:csid_mobile/database/course/model/model_course.dart';
import 'package:csid_mobile/database/payment_channel/model/model_payment_channel.dart';
import 'package:csid_mobile/database/preview/model/model_preview.dart';

abstract class StateOrder {}

class OrderInitial extends StateOrder {}

class OrderLoading extends StateOrder {}

class OrderLoaded extends StateOrder {
  final ModelLogin? auth;
  final int? courseId;
  final ModelCourse? course;
  final ModelPreview? previews;
  final List<ModelPaymentChannel>? paymentChannels;

  OrderLoaded({this.auth, this.courseId, this.course, this.previews, this.paymentChannels});

  OrderLoaded copyWith({
    ModelLogin? auth,
    int? courseId,
    ModelCourse? course,
    ModelPreview? previews,
    List<ModelPaymentChannel>? paymentChannels,
  }) {
    return OrderLoaded(
      auth: auth ?? this.auth,
      courseId: courseId ?? this.courseId,
      course: course ?? this.course,
      previews: previews ?? this.previews,
      paymentChannels: paymentChannels ?? this.paymentChannels,
    );
  }
}

class OrderError extends StateOrder {
  final String message;

  OrderError(this.message);
}
