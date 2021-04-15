import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../models/article_model.dart';
import '../screens/article_web_view.dart';

class ArticleDetail extends StatelessWidget {
  int indexInList;
  ArticleDetail(this.indexInList);

  @override
  Widget build(BuildContext context) {
    ArticleModel article =
        Provider.of<NewsProvider>(context, listen: false).items[indexInList];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              leading: Container(
                color: Colors.black54,
                child: BackButton(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  //padding: EdgeInsets.all(5),
                  child: ClipRRect(
                    //borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      article.urlToImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              floating: true,
              expandedHeight: 250,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Text(
                        article.title,
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                      child: Text(
                        article.description,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        maxLines: 100,
                      ),
                    ),
                    SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => ArticleWebView(article.url))
                        );
                      },
                      splashColor: Theme.of(context).accentColor,
                      child: Container(
                          height: 70,
                          margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            //borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Read Full Article',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ])),
                    )
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
