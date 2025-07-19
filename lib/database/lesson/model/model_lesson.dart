import 'package:csid_mobile/helpers/parser/parser_zero.dart';

class ModelLesson {
  ModelLesson({
    required this.id,
    this.title,
    this.source,
  });

  final int id;
  final String? title;
  final Source? source;

  factory ModelLesson.fromJson(Map<String, dynamic> json) {
    return ModelLesson(
      id: json['id'] is! int ? int.parse((json['id'] ?? '0')) : json['id'],
      title: json["title"] ?? '',
      source: Source.fromJson(json['source'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "source": source?.toJson(),
      };
}

class Source {
  Source({
    this.source,
    this.sourceEmbedded,
    this.poster,
    this.sourceExternalUrl,
    this.sourceShortcode,
    this.sourceYoutube,
    this.sourceVimeo,
    this.sourceVideoId,
    this.runtime,
    this.playtime,
  });

  final String? source;
  final String? sourceVideoId;
  final String? poster;
  final String? sourceExternalUrl;
  final String? sourceShortcode;
  final String? sourceYoutube;
  final String? sourceVimeo;
  final String? sourceEmbedded;
  final Runtime? runtime;
  final String? playtime;

  factory Source.fromJson(Map<String, dynamic> json) {
    String hours = "";
    String minutes = "";
    String seconds = "";

    if (!['0', '00'].contains(json['runtime']['hours'])) {
      hours = "${ParserZero.instance.set(int.parse(json['runtime']['hours'] ?? '00'))}:";
    }

    minutes = ParserZero.instance.set(int.parse(json['runtime']['minutes'] ?? '00'));
    seconds = ParserZero.instance.set(int.parse(json['runtime']['seconds'] ?? '00'));

    return Source(
      source: json['source'] ?? '',
      sourceVideoId: json["source_video_id"] ?? '',
      poster: json['poster'] ?? '',
      sourceExternalUrl: json['source_external_url'] ?? '',
      sourceShortcode: json['source_shortcode'] ?? '',
      sourceYoutube: json['source_youtube'] ?? '',
      sourceVimeo: json['source_vimeo'] ?? '',
      sourceEmbedded: json['source_embedded'] ?? '',
      runtime: Runtime.fromJson(json['runtime'] ?? ''),
      playtime: json['playtime'] ?? ("$hours$minutes:$seconds"),
    );
  }

  Map<String, dynamic> toJson() => {
        "source": source,
        "source_video_id": sourceVideoId,
        "poster": poster,
        "source_external_url": sourceExternalUrl,
        "source_shortcode": sourceShortcode,
        "source_youtube": sourceYoutube,
        "source_vimeo": sourceVimeo,
        "source_embedded": sourceEmbedded,
        "runtime": runtime!.toJson(),
        "playtime": playtime,
      };
}

class Runtime {
  Runtime({this.hours, this.minutes, this.seconds});

  final String? hours;
  final String? minutes;
  final String? seconds;

  factory Runtime.fromJson(Map<String, dynamic> json) {
    return Runtime(
      hours: json['hours'] ?? '',
      minutes: json["minutes"] ?? '',
      seconds: json['seconds'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "hours": hours,
        "minutes": minutes,
        "seconds": seconds,
      };
}
