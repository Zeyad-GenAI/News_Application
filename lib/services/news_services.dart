import 'package:dio/dio.dart';

import '../Model/article_model.dart';


class NewsServices {
  final Dio dio;
  final String apiKey = '01561f732f784f2b9ac6ec437d0614be';

  NewsServices(this.dio);

  Future<List<ArticleModel>> getNews({String category = 'general'}) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey&category=$category',
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles = jsonData['articles'];

      List<ArticleModel> articlesList = [];

      for (var article in articles) {
        ArticleModel articleModel = ArticleModel(
          image: article['urlToImage'],
          title: article['title'],
          subTitle: article['description'],
        );
        articlesList.add(articleModel);
      }
      return articlesList;
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  Future<List<ArticleModel>> searchNews(String query) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey&sortBy=relevancy',
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles = jsonData['articles'];

      List<ArticleModel> articlesList = [];

      for (var article in articles) {
        ArticleModel articleModel = ArticleModel(
          image: article['urlToImage'],
          title: article['title'],
          subTitle: article['description'],
        );
        articlesList.add(articleModel);
      }
      return articlesList;
    } catch (e) {
      throw Exception('Failed to search news: $e');
    }
  }
}