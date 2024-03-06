import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String email;
  final String name;
  final String surname;
  final  String about;
  final num age;
  final String favorite_books;
  final String favorite_authors;
  final String favorite_janars;
  final List<String>? favorite_posts = [];

  UserData(this.email, this.name, this.surname, this.about, this.age, this.favorite_authors, this.favorite_books, this.favorite_janars);

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'surname': surname,
    'about': about,
    'age': age,
    'favorite_books': favorite_books,
    'favorite_authors': favorite_authors,
    'favorite_janars': favorite_janars,
    'favorite_posts': favorite_posts,
  };

  static UserData fromJson(Map<String, dynamic> data) {
    return UserData(data['email'], data['name'], data['surname'], data['about'], data['age'], data['favorite_authors'], data['favorite_books'], data['favorite_janars']);
  }
}