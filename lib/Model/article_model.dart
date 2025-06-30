class ArticleModel {
  final String? image;
  final String title;
  final String? subTitle;
  final String? content;
  final String? url;
  final String? publishedAt;
  final String? author;
  final String? source;

  ArticleModel({
    required this.image,
    required this.title,
    required this.subTitle,
    this.content,
    this.url,
    this.publishedAt,
    this.author,
    this.source,
  }
  );
}