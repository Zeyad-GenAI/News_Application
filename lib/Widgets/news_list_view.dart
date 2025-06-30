import 'package:flutter/material.dart';

import '../Model/article_model.dart';
import '../services/news_services.dart';
import 'news_card.dart';
import 'package:dio/dio.dart';

class NewsListView extends StatefulWidget {
  final String category;

  const NewsListView({
    Key? key,
    this.category = 'general',
  }) : super(key: key);

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  List<ArticleModel> articles = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      articles = await NewsServices(Dio()).getNews(category: widget.category);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load news. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.amber,
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: getNews,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (articles.isEmpty) {
      return const Center(
        child: Text(
          'No news available for this category',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: NewsCard(
            articleModel: articles[index],
          ),
        );
      },
    );
  }
}