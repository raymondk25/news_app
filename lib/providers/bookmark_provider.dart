import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:news_app/consts/api_consts.dart';

import '../models/bookmarks_model.dart';
import 'package:http/http.dart' as http;

import '../models/news_model.dart';
import '../services/news_api.dart';

class BookmarkProvider extends ChangeNotifier {
  List<BookmarksModel> bookmarkList = [];

  List<BookmarksModel> get getbookmarkList {
    return bookmarkList;
  }

  Future<List<BookmarksModel>> fetchBookmarks() async {
    bookmarkList = await NewsAPIServices.getBookmarks() ?? [];
    // notifyListeners();
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
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteBookmark() async {
    try {
      var uri = Uri.https(kBaseUrlFirebase, "bookmarks/-N_mmadada26bPsXpMEy4A.json");
      var response = await http.delete(uri);

      log("Response status: ${response.statusCode}");
      log("Response status: ${response.body}");
    } catch (e) {
      throw e.toString();
    }
  }
}
