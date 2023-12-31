import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/inner_screens/search_screen.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:news_app/widgets/loading_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../consts/vars.dart';
import '../services/utils.dart';
import '../widgets/articles_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/tabs_widget.dart';
import '../widgets/top_tending.dart';
import '../widgets/vertical_spacing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  String sortBy = SortByEnum.publishedAt.name;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: color),
          centerTitle: true,
          title: Text(
            "News App",
            style: GoogleFonts.lobster(
              fontSize: 20,
              letterSpacing: 0.6,
              color: color,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    ctx: context,
                    inheritTheme: true,
                    type: PageTransitionType.rightToLeft,
                    child: const SearchScreen(),
                  ),
                );
              },
              icon: const Icon(IconlyLight.search),
            ),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  TabsWidget(
                    text: 'All News',
                    color: newsType == NewsType.allNews ? Theme.of(context).cardColor : Colors.transparent,
                    function: () {
                      if (newsType == NewsType.allNews) return;
                      setState(() {
                        newsType = NewsType.allNews;
                      });
                    },
                    fontSize: newsType == NewsType.allNews ? 22 : 14,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  TabsWidget(
                    text: 'Top Trending',
                    color: newsType == NewsType.topTrending ? Theme.of(context).cardColor : Colors.transparent,
                    function: () {
                      if (newsType == NewsType.topTrending) return;
                      setState(() {
                        newsType = NewsType.topTrending;
                      });
                    },
                    fontSize: newsType == NewsType.topTrending ? 22 : 14,
                  ),
                ],
              ),
              const VerticalSpacing(10),
              if (newsType == NewsType.allNews)
                SizedBox(
                  height: kBottomNavigationBarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      paginationButtons(
                          text: "Prev",
                          function: () {
                            if (currentPageIndex == 0) return;
                            setState(() {
                              currentPageIndex -= 1;
                            });
                          }),
                      Flexible(
                        flex: 2,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color: currentPageIndex == index ? Colors.blue : Theme.of(context).cardColor,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentPageIndex = index;
                                    });
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${index + 1}",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      paginationButtons(
                          text: "Next",
                          function: () {
                            if (currentPageIndex == 9) return;
                            setState(() {
                              currentPageIndex += 1;
                            });
                          }),
                    ],
                  ),
                ),
              const VerticalSpacing(10),
              if (newsType == NewsType.allNews)
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButton(
                          value: sortBy,
                          items: dropDownItems,
                          onChanged: (String? value) {
                            setState(() {
                              sortBy = value!;
                            });
                          }),
                    ),
                  ),
                ),
              const VerticalSpacing(10),
              FutureBuilder<List<NewsModel>>(
                  future: newsType == NewsType.allNews
                      ? newsProvider.fetchAllNews(pageIndex: currentPageIndex + 1, sortBy: sortBy)
                      : newsProvider.fetchTopHeadlines(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return newsType == NewsType.allNews
                          ? LoadingWidget(newsType: newsType)
                          : Expanded(child: LoadingWidget(newsType: newsType));
                    } else if (snapshot.hasError) {
                      return Expanded(
                        child: EmptyNewsWidget(
                            text: "An error occured ${snapshot.error}", imagePath: 'assets/images/no_news.png'),
                      );
                    } else if (snapshot.data == null) {
                      return const Expanded(
                          child: EmptyNewsWidget(text: "No news found", imagePath: 'assets/images/no_news.png'));
                    }
                    return newsType == NewsType.allNews
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (ctx, index) {
                                  return ChangeNotifierProvider.value(
                                    value: snapshot.data![index],
                                    child: const ArticlesWidget(),
                                  );
                                }),
                          )
                        : SizedBox(
                            height: size.height * 0.65,
                            child: Swiper(
                              itemCount: 5,
                              autoplay: true,
                              autoplayDelay: 8000,
                              viewportFraction: 0.9,
                              itemWidth: size.width * 0.9,
                              layout: SwiperLayout.STACK,
                              itemBuilder: (ctx, index) {
                                return ChangeNotifierProvider.value(
                                  value: snapshot.data![index],
                                  child: const TopTrendingWidget(),
                                );
                              },
                            ),
                          );
                  }))
              // LoadingWidget(newsType: newsType),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text(SortByEnum.relevancy.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text(SortByEnum.publishedAt.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(SortByEnum.popularity.name),
      ),
    ];
    return menuItem;
  }

  ElevatedButton paginationButtons({required String text, required Function function}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: const EdgeInsets.all(6),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
