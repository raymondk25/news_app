import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../consts/api_consts.dart';
import '../consts/http_exceptions.dart';
import '../models/bookmarks_model.dart';
import '../models/news_model.dart';

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

  static Future<List<NewsModel>> searchNews({required String query}) async {
    try {
      var uri = Uri.https(kBaseUrl, "v2/top-headlines", {
        "q": query,
        "pageSize": "10",
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

  static Future<List<BookmarksModel>?> getBookmarks() async {
    try {
      var uri = Uri.https(kBaseUrlFirebase, "bookmarks.json");
      var response = await http.get(uri);

      // log("Response status: ${response.statusCode}");
      // log("Response status: ${response.body}");

      Map data = jsonDecode(response.body);
      List allKeys = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (String key in data.keys) {
        allKeys.add(key);
      }
      log(allKeys.toString());
      return BookmarksModel.bookmarksFromSnapshot(json: data, allKeys: allKeys);
    } catch (e) {
      throw e.toString();
    }
  }
}
