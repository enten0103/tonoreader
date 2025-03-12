import 'dart:convert';

///ApifoxModel
class BookDetailModel {
  final BookDetailAbout? about;
  final BookDetailChapter? chapter;
  final BookDetailHead? head;

  ///ID 编号
  final String id;
  final BookDetailSeries? series;
  final BookDetailStatistics? statistics;

  BookDetailModel({
    this.about,
    this.chapter,
    this.head,
    required this.id,
    this.series,
    this.statistics,
  });

  factory BookDetailModel.fromJson(String str) =>
      BookDetailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookDetailModel.fromMap(Map<String, dynamic> json) => BookDetailModel(
        about: json["about"] == null
            ? null
            : BookDetailAbout.fromMap(json["about"]),
        chapter: json["chapter"] == null
            ? null
            : BookDetailChapter.fromMap(json["chapter"]),
        head:
            json["head"] == null ? null : BookDetailHead.fromMap(json["head"]),
        id: json["id"],
        series: json["series"] == null
            ? null
            : BookDetailSeries.fromMap(json["series"]),
        statistics: json["statistics"] == null
            ? null
            : BookDetailStatistics.fromMap(json["statistics"]),
      );

  Map<String, dynamic> toMap() => {
        "about": about?.toMap(),
        "chapter": chapter?.toMap(),
        "head": head?.toMap(),
        "id": id,
        "series": series?.toMap(),
        "statistics": statistics?.toMap(),
      };
}

///book_detail_about
class BookDetailAbout {
  ///标签
  final List<BookDetailAboutRow> info;

  ///标签
  final List<BookTag> tags;
  final String value;

  BookDetailAbout({
    required this.info,
    required this.tags,
    required this.value,
  });

  factory BookDetailAbout.fromJson(String str) =>
      BookDetailAbout.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookDetailAbout.fromMap(Map<String, dynamic> json) => BookDetailAbout(
        info: List<BookDetailAboutRow>.from(
            json["info"].map((x) => BookDetailAboutRow.fromMap(x))),
        tags: List<BookTag>.from(json["tags"].map((x) => BookTag.fromMap(x))),
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "info": List<dynamic>.from(info.map((x) => x.toMap())),
        "tags": List<dynamic>.from(tags.map((x) => x.toMap())),
        "value": value,
      };
}

///book_detail_about_row
class BookDetailAboutRow {
  final String key;
  final List<BookTag> value;

  BookDetailAboutRow({
    required this.key,
    required this.value,
  });

  factory BookDetailAboutRow.fromJson(String str) =>
      BookDetailAboutRow.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookDetailAboutRow.fromMap(Map<String, dynamic> json) =>
      BookDetailAboutRow(
        key: json["key"],
        value: List<BookTag>.from(json["value"].map((x) => BookTag.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": List<dynamic>.from(value.map((x) => x.toMap())),
      };
}

///BookTag
class BookTag {
  ///ID 编号
  final String id;

  ///名称
  final String value;

  BookTag({
    required this.id,
    required this.value,
  });

  factory BookTag.fromJson(String str) => BookTag.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookTag.fromMap(Map<String, dynamic> json) => BookTag(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "value": value,
      };
}

///book_detail_chapter
class BookDetailChapter {
  final BookReadingProgress? progress;
  final List<BookChapter> value;

  BookDetailChapter({
    required this.progress,
    required this.value,
  });

  factory BookDetailChapter.fromJson(String str) =>
      BookDetailChapter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookDetailChapter.fromMap(Map<String, dynamic> json) =>
      BookDetailChapter(
        progress: json["progress"] == null
            ? null
            : BookReadingProgress.fromMap(json["progress"]),
        value: List<BookChapter>.from(
            json["value"].map((x) => BookChapter.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "progress": progress?.toMap(),
        "value": List<dynamic>.from(value.map((x) => x.toMap())),
      };
}

///BookReadingProgress
class BookReadingProgress {
  final BookChapter chapter;
  final int readingProgress;

  BookReadingProgress({
    required this.chapter,
    required this.readingProgress,
  });

  factory BookReadingProgress.fromJson(String str) =>
      BookReadingProgress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookReadingProgress.fromMap(Map<String, dynamic> json) =>
      BookReadingProgress(
        chapter: BookChapter.fromMap(json["chapter"]),
        readingProgress: json["readingProgress"],
      );

  Map<String, dynamic> toMap() => {
        "chapter": chapter.toMap(),
        "readingProgress": readingProgress,
      };
}

///BookChapter
class BookChapter {
  ///ID 编号
  final String id;

  ///名称
  final String name;

  BookChapter({
    required this.id,
    required this.name,
  });

  factory BookChapter.fromJson(String str) =>
      BookChapter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookChapter.fromMap(Map<String, dynamic> json) => BookChapter(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

///book_detail_head
class BookDetailHead {
  final Author? author;
  final List<String>? customize;
  final Publisher? publisher;
  final Title title;

  BookDetailHead({
    this.author,
    this.customize,
    this.publisher,
    required this.title,
  });

  factory BookDetailHead.fromJson(String str) =>
      BookDetailHead.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookDetailHead.fromMap(Map<String, dynamic> json) => BookDetailHead(
        author: json["author"] == null ? null : Author.fromMap(json["author"]),
        customize: json["customize"] == null
            ? []
            : List<String>.from(json["customize"]!.map((x) => x)),
        publisher: json["publisher"] == null
            ? null
            : Publisher.fromMap(json["publisher"]),
        title: Title.fromMap(json["title"]),
      );

  Map<String, dynamic> toMap() => {
        "author": author?.toMap(),
        "customize": customize == null
            ? []
            : List<dynamic>.from(customize!.map((x) => x)),
        "publisher": publisher?.toMap(),
        "title": title.toMap(),
      };
}

class Author {
  final String? link;
  final String value;

  Author({
    this.link,
    required this.value,
  });

  factory Author.fromJson(String str) => Author.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Author.fromMap(Map<String, dynamic> json) => Author(
        link: json["link"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "link": link,
        "value": value,
      };
}

class Publisher {
  final String? link;
  final String value;

  Publisher({
    this.link,
    required this.value,
  });

  factory Publisher.fromJson(String str) => Publisher.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Publisher.fromMap(Map<String, dynamic> json) => Publisher(
        link: json["link"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "link": link,
        "value": value,
      };
}

class Title {
  final String? link;
  final String value;

  Title({
    this.link,
    required this.value,
  });

  factory Title.fromJson(String str) => Title.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Title.fromMap(Map<String, dynamic> json) => Title(
        link: json["link"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "link": link,
        "value": value,
      };
}

///book_detail_series
class BookDetailSeries {
  final List<Book> books;

  ///ID 编号
  final String id;
  final String title;

  BookDetailSeries({
    required this.books,
    required this.id,
    required this.title,
  });

  factory BookDetailSeries.fromJson(String str) =>
      BookDetailSeries.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookDetailSeries.fromMap(Map<String, dynamic> json) =>
      BookDetailSeries(
        books: List<Book>.from(json["books"].map((x) => Book.fromMap(x))),
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "books": List<dynamic>.from(books.map((x) => x.toMap())),
        "id": id,
        "title": title,
      };
}

class Book {
  final String coverUrl;

  ///ID 编号
  final String id;

  ///名称
  final String title;

  Book({
    required this.coverUrl,
    required this.id,
    required this.title,
  });

  factory Book.fromJson(String str) => Book.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Book.fromMap(Map<String, dynamic> json) => Book(
        coverUrl: json["coverUrl"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "coverUrl": coverUrl,
        "id": id,
        "title": title,
      };
}

///book_detail_statistics
class BookDetailStatistics {
  final int collections;
  final int comments;
  final bool hasCollected;
  final double score;
  final String type;

  BookDetailStatistics({
    required this.collections,
    required this.comments,
    required this.hasCollected,
    required this.score,
    required this.type,
  });

  factory BookDetailStatistics.fromJson(String str) =>
      BookDetailStatistics.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookDetailStatistics.fromMap(Map<String, dynamic> json) =>
      BookDetailStatistics(
        collections: json["collections"],
        comments: json["comments"],
        hasCollected: json["hasCollected"],
        score: json["score"]?.toDouble(),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "collections": collections,
        "comments": comments,
        "hasCollected": hasCollected,
        "score": score,
        "type": type,
      };
}
