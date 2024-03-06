class BookData {
  String author;
  String description;
  String title;
  List<String> images = [];

  BookData(this.author, this.description, this.images, this.title);
  Map<String, dynamic> toJson() => {
    'author': author,
    'description': description,
    'images': images,
    'title': title,
  };

  static getBookList(List data) {
    List<BookData> result = [];
    for(final book in data) {
      List<String> images = (book['images'] as List).map((e) => e as String).toList();
      result.add(BookData(book['author'], book['description'], images, book['title']));
    }
    return result;
  }
}