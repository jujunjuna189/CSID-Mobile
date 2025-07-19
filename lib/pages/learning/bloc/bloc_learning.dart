import 'package:csid_mobile/pages/learning/state/state_learning.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocLearning extends Cubit<StateLearning> {
  BlocLearning() : super(LearningInitial());

  @override
  void onChange(Change<StateLearning> change) {
    super.onChange(change);
  }
}
