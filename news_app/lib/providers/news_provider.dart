import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/article_model.dart';

class NewsProvider with ChangeNotifier {
  List<ArticleModel> _items = [];
  static const String APIkey = "c4c2a52b07ac4c24974b60e5b2f9c5d8";
  bool _hasNoError = true;
  bool isWaiting = true;
  bool get isErrorFree {
    return _hasNoError;
  }

  List<ArticleModel> get items {
    return [..._items];
  }

  String _lastUrl =
      'https://newsapi.org/v2/top-headlines?country=in&' + 'apiKey=' + APIkey;

  Future<void> fetchNews(
      {String endpoint = "",
      String category = "",
      String providedUrl = "",
      String query = ""}) async {
    isWaiting = true;
    _hasNoError = true;
    String domain = 'https://newsapi.org/v2/';
    String api = 'apiKey=' + APIkey;
    String tempurl;
    if (providedUrl.isNotEmpty) {
      tempurl = providedUrl;
    } else if (endpoint.isNotEmpty) {
      notifyListeners();
      print('endpoint found');
      tempurl = domain + endpoint + '?';
      if (category.isNotEmpty) {
        tempurl += 'category=' + category + '&';
      }
      if (query.isNotEmpty) {
        tempurl += 'q' + query + '&';
      }
      tempurl += 'country=in&' + api;
    } else {
      String query = '';
      String url = domain + endpoint + '?' + query + api;
      //tempurl = 'https://newsapi.org/v2/top_headlines?country=in&' + api;
      tempurl = 'https://newsapi.org/v2/everything?language=en&q=(+modi AND +mamta)&' + api;
    }
    _lastUrl = tempurl;
    try {
      var response = await http.get(Uri.parse(tempurl));
      final extractedData = jsonDecode(response.body);
      //print(extractedData);
      if(response.statusCode >= 400) throw Error();
      if (extractedData['status'] == "ok") {
        List<ArticleModel> loadedArticles = [];
        List<dynamic> extractedArticles = extractedData['articles'];
        extractedArticles.forEach((elem) {
          Map<String, dynamic> singleArticle = elem;
          if (singleArticle['url'] != null &&
              singleArticle['urlToImage'] != null) {
            loadedArticles.add(ArticleModel.parseJsonToArticleModel(elem));
          }
        });
        _items = loadedArticles;
        //print(_items.length);
        // _items.forEach((element) {
        //   print(element.title);
        // });

      }
    } catch (e) {
      _hasNoError = false;
      print(e);
    }
    isWaiting = false;
    notifyListeners();
  }

  Future<void> fetchLastRequest() async {
    await fetchNews(providedUrl: _lastUrl);
  }

  // Future<void> fetchFromEverything(String q) async {
  //   String api = 'apiKey=' + APIkey;
  //   String url = 'https://newsapi.org/v2/everything?language=en&';
  //   q = q.trim();
  //   q = q.replaceAll(RegExp('\\s+'), "OR");
  //   q.sp
  //   url += api;
  //   await fetchNews(providedUrl: url);
  // }
}
