import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/vertical_spacing.dart';

import '../widgets/tabs_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
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
              onPressed: () {},
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
              newsType == NewsType.topTrending
                  ? const SizedBox.shrink()
                  : SizedBox(
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
                    )
            ],
          ),
        ),
      ),
    );
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
