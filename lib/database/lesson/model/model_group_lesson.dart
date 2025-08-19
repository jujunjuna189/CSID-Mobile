import 'package:csid_mobile/database/lesson/model/model_lesson.dart';

class ModelGroupLesson {
  final String? title;
  final List<ModelLesson>? lessons;

  ModelGroupLesson({this.title, this.lessons});

  factory ModelGroupLesson.fromJson(Map<String, dynamic> json) {
    return ModelGroupLesson(
      title: json['title'],
      lessons: (json['items'] as List).map((item) => ModelLesson.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "items": (lessons ?? []).map((e) => e.toJson()).toList(),
      };
}
