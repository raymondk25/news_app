import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/drawer_widget.dart';

import '../widgets/tabs_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
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
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TabsWidget(
                  text: 'All news',
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
          )
        ]),
      ),
    );
  }
}
