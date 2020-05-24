import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=ec5cfebef25e45178e7eef55ec69123a";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach(
        (element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
            );
            news.add(articleModel);
          }
        },
      );
    }
  }
}
