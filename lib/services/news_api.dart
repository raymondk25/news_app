import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

class NewsAPIServices {
  static Future<List<NewsModel>> getAllNews() async {
    var url =
        Uri.parse("https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=39bcc9134cd84749b9ae30dbb6bdea28");
    var response = await http.get(url);

    Map data = jsonDecode(response.body);
    List newsTempList = [];
    for (var v in data["articles"]) {
      newsTempList.add(v);
    }
    return NewsModel.newsFromSnapshot(newsTempList);
  }
}
