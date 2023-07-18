import 'package:flutter/cupertino.dart';
import 'package:news_app/services/news_api.dart';

import '../models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

  Future<List<NewsModel>> fetchAllNews({required int pageIndex}) async {
    newsList = await NewsAPIServices.getAllNews(page: pageIndex);
    return newsList;
  }
}
