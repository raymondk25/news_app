import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:news_app/consts/api_consts.dart';

import '../models/bookmarks_model.dart';
import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class BookmarkProvider extends ChangeNotifier {
  List<BookmarksModel> bookmarkList = [];

  List<BookmarksModel> get getbookmarkList {
    return bookmarkList;
  }

  Future<void> addToBookmark({required NewsModel newsModel}) async {
    try {
      var uri = Uri.https(kBaseUrlFirebase, "bookmarks.json");
      var response = await http.post(
        uri,
        body: json.encode(
          newsModel.toJson(),
        ),
      );

      log("Response status: ${response.statusCode}");
      log("Response status: ${response.body}");
      // Map data = jsonDecode(response.body);
      // List newsTempList = [];
      // if (data['code'] != null) {
      //   throw HttpException(data['code']);
      // }
      // for (var v in data["articles"]) {
      //   newsTempList.add(v);
      // }
      // return NewsModel.newsFromSnapshot(newsTempList);
    } catch (e) {
      throw e.toString();
    }
  }
}
