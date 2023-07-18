import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/consts/api_consts.dart';
import 'package:news_app/consts/http_exceptions.dart';
import 'package:news_app/models/news_model.dart';

class NewsAPIServices {
  static Future<List<NewsModel>> getAllNews({required int page, required String sortBy}) async {
    try {
      var uri = Uri.https(kBaseUrl, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "5",
        "page": page.toString(),
        "sortBy": sortBy,
        "domains": "bbc.co.uk,techcrunch.com,engadget.com",
      });
      var response = await http.get(uri, headers: {"X-Api-Key": kApiKey});

      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<NewsModel>> getTopHeadlines() async {
    try {
      var uri = Uri.https(kBaseUrl, "v2/top-headlines", {"country": "us"});
      var response = await http.get(uri, headers: {"X-Api-Key": kApiKey});

      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (e) {
      throw e.toString();
    }
  }
}
