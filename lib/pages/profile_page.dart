import 'package:book_blog/utils/book.dart';
import 'package:book_blog/utils/firebase_data_service.dart';
import 'package:book_blog/utils/user.dart';
import 'package:book_blog/widgets/app_bar.dart';
import 'package:book_blog/widgets/profile_label.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar_widget.dart';
import 'book_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _profileInfoWidget() {
    return FutureBuilder(
      future: FirebaseDataService.getUserData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Text('Loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return createListView(context, snapshot);
            }
        }
      },
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    UserData userData = snapshot.data;
    if(userData.toString().isEmpty) {
      return const Text('Nothing is here');
    }
    return ListView(
      children: [
        ProfileSection(text: userData.email, currentIndex: 0),
        ProfileSection(text: userData.name, currentIndex: 1),
        ProfileSection(text: userData.surname, currentIndex: 2),
        ProfileSection(text: userData.about, currentIndex: 3),
        ProfileSection(text: userData.age.toString(), currentIndex: 4),
        ProfileSection(text: userData.favorite_books, currentIndex: 5),
        ProfileSection(text: userData.favorite_authors, currentIndex: 6),
        ProfileSection(text: userData.favorite_janars, currentIndex: 7),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile Page'),
      body: _profileInfoWidget(),
      bottomNavigationBar: const CustomBottomNavigationBarWidget(currentIndex: 2),
    );
  }
}
