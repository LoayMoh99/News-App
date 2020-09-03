import 'package:http/http.dart' as http;
import 'package:news_app_api/models/article.dart';
import 'package:news_app_api/models/country.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

String apiKey = "41bcedfe739642d8bb24bb0900aa2048";

class News {
  List<Article> news = [];

  Future<void> getNews(context) async {
    String countryCode =
        Provider.of<Country>(context, listen: true).countryCode;
    String url =
        "http://newsapi.org/v2/top-headlines?country=$countryCode&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=$apiKey";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsForCategorie {
  List<Article> news = [];

  Future<void> getNewsForCategory(String category, context) async {
    String countryCode = Provider.of<Country>(context).countryCode;
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url =
        "http://newsapi.org/v2/top-headlines?country=$countryCode&category=$category&apiKey=$apiKey";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
