class ModelCourse {
  ModelCourse({
    required this.id,
    this.title,
    this.slug,
    this.date,
    this.authorName,
    this.thumbnail,
    this.link,
    this.enrolledCount,
    this.salePrice,
  });

  final int id;
  final String? title;
  final String? slug;
  final String? date;
  final String? authorName;
  final String? thumbnail;
  final String? link;
  final int? enrolledCount;
  final int? salePrice;

  factory ModelCourse.fromJson(Map<String, dynamic> json) {
    return ModelCourse(
      id: json['id'] is! int ? int.parse((json['id'] ?? '0')) : json['id'],
      title: json["title"] ?? '',
      slug: json['slug'] ?? '',
      date: json['date'] ?? "",
      authorName: json['author_name'] ?? "",
      thumbnail: json['thumbnail'] ?? "",
      link: json['link'] ?? "",
      enrolledCount:
          json['enrolled_count'] is! int ? int.parse((json['enrolled_count'] ?? '0')) : json['enrolled_count'],
      salePrice: int.parse((json['sale_price'] ?? 0).toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "date": date,
        "author_name": authorName,
        "thumbnail": thumbnail,
        "link": link,
        "enrolled_count": enrolledCount,
        "sale_price": salePrice,
      };
}
