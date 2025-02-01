class BookBlockModule {
  BookBlockModule(
      {required this.id,
      required this.title,
      required this.value,
      required this.books});
  String id;
  String title;
  String value;
  List<BookInfoModule> books;
  factory BookBlockModule.fromJson(Map<String, dynamic> json) {
    return BookBlockModule(
      id: json['id'] as String,
      title: json['title'] as String,
      value: json['value'] as String,
      books: (json['books'] as List<dynamic>)
          .map((e) => BookInfoModule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BookInfoModule {
  BookInfoModule(
      {required this.id,
      required this.coverUrl,
      required this.name,
      this.series,
      this.seriesId,
      this.season,
      this.authorName,
      this.authorId,
      this.score});
  String id;
  String coverUrl;
  String name;
  String? series;
  String? seriesId;
  String? season;
  String? authorName;
  String? authorId;
  double? score;

  factory BookInfoModule.fromJson(Map<String, dynamic> json) {
    return BookInfoModule(
      id: json['id'] as String,
      coverUrl: json['coverUrl'] as String,
      name: json['name'] as String,
      series: json['series'] as String?,
      seriesId: json['seriesId'] as String?,
      season: json['season'] as String?,
      authorName: json['authorName'] as String?,
      authorId: json['authorId'] as String?,
      score: double.parse(json['score'] as String),
    );
  }
}
