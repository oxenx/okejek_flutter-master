import 'dart:convert';

HomeNews homeNewsFromJson(String str) => HomeNews.fromJson(json.decode(str));

String homeNewsToJson(HomeNews data) => json.encode(data.toJson());

class HomeNews {
  HomeNews({
    required this.id,
    required this.title,
    required this.link,
    required this.date,
    required this.jetpackFeaturedMediaUrl,
  });

  int id;
  Title title;
  DateTime date;
  String link;
  String jetpackFeaturedMediaUrl;

  factory HomeNews.fromJson(Map<String, dynamic> json) => HomeNews(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        link: json["link"],
        title: Title.fromJson(json["title"]),
        jetpackFeaturedMediaUrl: json["jetpack_featured_media_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "link": link,
        "title": title.toJson(),
        "jetpack_featured_media_url": jetpackFeaturedMediaUrl,
      };
}

class Title {
  Title({
    required this.rendered,
  });

  String rendered;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}
