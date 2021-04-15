class ArticleModel {
  String sourceId;
  String sourceName;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  ArticleModel(
      {this.sourceId = "",
      this.sourceName = "",
      this.author = "",
      this.title = "",
      this.description = "",
      this.url = "",
      this.urlToImage = "",
      this.publishedAt = "",
      this.content = ""});

  static ArticleModel parseJsonToArticleModel(dynamic elem) {
    Map<String, dynamic> singleArticle = elem;
    Map<String, dynamic> sourceInformation = singleArticle['source'];

    return ArticleModel(
        sourceId: sourceInformation['id'],
        sourceName: sourceInformation['name'],
        author: singleArticle['author'],
        title: singleArticle['title'],
        description: singleArticle['description'],
        url: singleArticle['url'],
        urlToImage: singleArticle['urlToImage'],
        publishedAt: singleArticle['publishedAt'],
        content: singleArticle['content']);
  }
}
