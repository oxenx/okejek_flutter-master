// To parse this JSON data, do
//
//     final newsItem = newsItemFromJson(jsonString);

import 'dart:convert';

NewsItem newsItemFromJson(String str) => NewsItem.fromJson(json.decode(str));

String newsItemToJson(NewsItem data) => json.encode(data.toJson());

class NewsItem {
  NewsItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.url,
    required this.createdAt,
    required this.image,
    required this.notificationTitle,
    required this.notificationContent,
  });

  int id;
  String title;
  String summary;
  String content;
  String url;
  DateTime createdAt;
  String image;
  String notificationTitle;
  String notificationContent;

  factory NewsItem.fromJson(Map<String, dynamic> json) => NewsItem(
        id: json["id"],
        title: json["title"],
        summary: json["summary"],
        content: json["content"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        image: json["image"],
        notificationTitle: json["notification_title"],
        notificationContent: json["notification_content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "summary": summary,
        "content": content,
        "url": url,
        "created_at": createdAt.toIso8601String(),
        "image": image,
        "notification_title": notificationTitle,
        "notification_content": notificationContent,
      };
}
