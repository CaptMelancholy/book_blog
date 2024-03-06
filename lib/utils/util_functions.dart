import 'package:book_blog/utils/book.dart';

class UtilFunctions {

  static checkListType(List list) {
    if(list.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static findElement(List<BookData> list, BookData element) {
    for(final book in list) {
      if(book.title == element.title && book.author == element.author) {
        return true;
      }
    }
    return false;
  }
}