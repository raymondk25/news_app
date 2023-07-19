import 'package:flutter/cupertino.dart';

class BookmarksModel with ChangeNotifier {
  String newsId,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      dateToShow,
      content,
      readingTimeText;

  BookmarksModel({
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.dateToShow,
    required this.readingTimeText,
  });

  factory BookmarksModel.fromJson(dynamic json) {
    return BookmarksModel(
      newsId: json['newsId'] ?? "",
      sourceName: json['sourceName'] ?? "",
      authorName: json['authorName'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? 'https://cdn-icons-png.flaticon.com/512/833/833268.png',
      publishedAt: json['publishedAt'] ?? '',
      dateToShow: json['dateToShow'] ?? "",
      content: json['content'] ?? "",
      readingTimeText: json['readingTimeText'] ?? "",
    );
  }

  static List<BookmarksModel> bookmarksFromSnapshot(List newSnapshot) {
    return newSnapshot.map((data) {
      return BookmarksModel.fromJson(data);
    }).toList();
  }

  // @override
  // String toString() {
  //   return 'news {newsId: $newsId, sourceName: $sourceName, authorName: $authorName, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content,}';
  // }
}
