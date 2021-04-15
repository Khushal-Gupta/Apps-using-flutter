import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class CategoryScroll extends StatefulWidget {
  @override
  _CategoryScrollState createState() => _CategoryScrollState();
}

class _CategoryScrollState extends State<CategoryScroll> {
  final List<String> categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (ctx, index) => Padding(
        padding: EdgeInsets.all(3.0),
        child: ActionChip(
          pressElevation: 15,
          backgroundColor: Colors.white,
          label: Text(CapFirstLetter(categories[index])),
          onPressed: () {
            Provider.of<NewsProvider>(context, listen: false).fetchNews(endpoint: 'top-headlines', category: categories[index]);
          },
        ),
      ),
    );
  }
}

String CapFirstLetter(String str){
  return str[0].toUpperCase() + str.substring(1);
}
