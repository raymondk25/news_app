import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/consts/api_consts.dart';
import 'package:news_app/models/news_model.dart';

class NewsAPIServices {
  static Future<List<NewsModel>> getAllNews() async {
    var uri = Uri.https(kBaseUrl, "v2/everything", {
      "q": "bitcoin",
      "pageSize": "5",
      "domains": "bbc.co.uk,techcrunch.com,engadget.com",
    });
    var response = await http.get(uri, headers: {"X-Api-Key": kApiKey});

    Map data = jsonDecode(response.body);
    // log(data.toString());
    List newsTempList = [];
    for (var v in data["articles"]) {
      newsTempList.add(v);
    }
    return NewsModel.newsFromSnapshot(newsTempList);
  }
}
