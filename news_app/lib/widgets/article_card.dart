import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../screens/article_detail.dart';

class ArticleCard extends StatelessWidget {
  int indexInList;

  ArticleCard(this.indexInList);

  @override
  Widget build(BuildContext context) {
    ArticleModel article =
        Provider.of<NewsProvider>(context, listen: false).items[indexInList];
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => ArticleDetail(indexInList)));
      },
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                article.urlToImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 70,
                color: Colors.black.withOpacity(0.7),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  article.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
