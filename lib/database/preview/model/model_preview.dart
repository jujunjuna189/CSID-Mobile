class ModelPreview {
  ModelPreview({
    required this.metaId,
    required this.postId,
    this.metaKey,
    this.metaValue,
  });

  final int metaId;
  final int postId;
  final String? metaKey;
  final List<MetaValue>? metaValue;

  factory ModelPreview.fromJson(Map<String, dynamic> json) {
    final rawMetaValue = json['meta_value'];

    return ModelPreview(
      metaId: json['meta_id'] is! int ? int.parse((json['meta_id'] ?? '0')) : json['meta_id'],
      postId: json['post_id'] is! int ? int.parse((json['post_id'] ?? '0')) : json['post_id'],
      metaKey: json["meta_key"] ?? '',
      metaValue: rawMetaValue is List ? rawMetaValue.map((e) => MetaValue.fromJson(e)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "meta_id": metaId,
        "post_id": postId,
        "meta_key": metaKey,
        "meta_value": metaValue?.map((e) => e.toJson()),
      };
}

class MetaValue {
  MetaValue({
    this.title,
    this.youtubeUrl,
    this.duration,
    this.vimeoUrl,
  });

  final String? title;
  final String? youtubeUrl;
  final String? duration;
  final String? vimeoUrl;

  factory MetaValue.fromJson(Map<String, dynamic> json) {
    return MetaValue(
      title: json['title'] ?? '',
      youtubeUrl: json["youtube_url"] ?? '',
      duration: json['duration'] ?? '',
      vimeoUrl: json['vimeo_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "youtube_url": youtubeUrl,
        "duration": duration,
        "vimeo_url": vimeoUrl,
      };
}
