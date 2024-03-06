import 'package:book_blog/utils/book.dart';
import 'package:book_blog/utils/firebase_auth_service.dart';
import 'package:book_blog/utils/user.dart';
import 'package:book_blog/utils/util_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDataService {

  static createDatabaseUser(String id, UserData user) async {
    var db = FirebaseFirestore.instance;
    await db.collection('users').doc(id).set(user.toJson());
  }

  static Future<List<BookData>> getFavoriteBooks() async {
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final userData = await db.collection('users').doc(user?.uid).get();
    final data = userData.data() as Map<String, dynamic>;
    if(UtilFunctions.checkListType(data['favorite_posts'])) {
      List<BookData> books = BookData.getBookList(data['favorite_posts']);
      return books;
    }
    return [];
  }

  static getUserData() async {
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final firebaseObj = await db.collection('users').doc(user?.uid).get();
    final data = firebaseObj.data() as Map<String, dynamic>;
    final UserData userData = UserData.fromJson(data);
    return userData;
  }

  static Future<List<BookData>> getAllBooks() async {
    final db = FirebaseFirestore.instance;
    var data = await db.collection("books").get();
    final allData = data.docs.map((doc) => doc.data()).toList();
    final List<BookData> books = BookData.getBookList(allData);
    return books;
  }

  
  static Future<bool> pushFavoriteBookToUser(BookData book) async {
    var db = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    try {
      await db.collection('users').doc(user?.uid).update({
        'favorite_posts': FieldValue.arrayUnion([book.toJson()]),
      });
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  static Future<bool> popFavoriteBookFromUser(BookData book) async {
    var db = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    try {
      await db.collection('users').doc(user?.uid).update({
        'favorite_posts': FieldValue.arrayRemove([book.toJson()]),
      });
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  static bool compareElements(BookData elementOne, BookData elementTwo) {
    if(elementOne.title == elementTwo.title && elementOne.author == elementTwo.author) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkUserFavoriteBook(BookData book) async {
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final userData = await db.collection('users').doc(user?.uid).get();
    final data = userData.data() as Map<String, dynamic>;
    final arr = data['favorite_posts'];
    if(UtilFunctions.checkListType(arr)) {
      List<BookData> books = BookData.getBookList(data['favorite_posts']);
      return UtilFunctions.findElement(books, book);
    }
    return false;

  }
}