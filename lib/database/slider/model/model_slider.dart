class ModelSlider {
  final String? source;

  ModelSlider({this.source});

  factory ModelSlider.fromJson(Map<String, dynamic> json) {
    return ModelSlider(
      source: json['source'],
    );
  }

  Map<String, dynamic> toJson() => {
        "source": source,
      };
}
