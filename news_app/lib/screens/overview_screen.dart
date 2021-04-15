import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/category_scroll.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../models/article_model.dart';
import '../widgets/article_card.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  List<ArticleModel> articles = [];
  Future<void> fetchNewsFuture;
  bool isInit = false;

  @override
  void didChangeDependencies() {
    if (!isInit) {
      isInit = true;
      fetchNewsFuture =
          Provider.of<NewsProvider>(context, listen: false).fetchNews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enjoy your news!'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            color: Colors.amber,
            height: 50,
            width: double.infinity,
            child: Center(child: CategoryScroll()),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchNewsFuture,
              builder: (ctx, snapshot) =>
                  (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: () =>
                              Provider.of<NewsProvider>(context, listen: false)
                                  .fetchLastRequest(),
                          child: Consumer<NewsProvider>(
                            builder: (ctx, newsProvider, _) =>
                                CorrectWidget(ctx, newsProvider),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget CorrectWidget(BuildContext ctx, NewsProvider newsProvider) {
  if (newsProvider.isWaiting == true) {
    return Center(child: CircularProgressIndicator());
  }
  if (newsProvider.isErrorFree)
    return ListView.builder(
      shrinkWrap: true,
      itemCount: newsProvider.items.length,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ArticleCard(index),
        );
      },
    );

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
    Text(
      'Some unexpected error ocurred!',
      style: TextStyle(fontSize: 20),
      softWrap: true,
      textAlign: TextAlign.center,
    ),
    Text(
      'Please try again...',
      style: TextStyle(fontSize: 20),
      softWrap: true,
      textAlign: TextAlign.center,
    ),
  ]);
}
