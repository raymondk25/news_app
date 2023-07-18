import 'package:flutter/cupertino.dart';
import 'package:news_app/services/news_api.dart';

import '../models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

  Future<List<NewsModel>> fetchAllNews({required int pageIndex, required String sortBy}) async {
    newsList = await NewsAPIServices.getAllNews(page: pageIndex, sortBy: sortBy);
    return newsList;
  }

  Future<List<NewsModel>> fetchTopHeadlines() async {
    newsList = await NewsAPIServices.getTopHeadlines();
    return newsList;
  }

  NewsModel findByDate({required String publishedAt}) {
    return newsList.firstWhere((element) => element.publishedAt == publishedAt);
  }
}
