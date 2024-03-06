import 'package:book_blog/pages/main_page.dart';
import 'package:book_blog/utils/book.dart';
import 'package:book_blog/utils/firebase_data_service.dart';
import 'package:book_blog/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_blog/utils/firebase_auth_service.dart';

import '../widgets/bottom_navigation_bar_widget.dart';
import 'book_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Widget booksWidget() {
    return FutureBuilder(
      future: FirebaseDataService.getFavoriteBooks(),
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
    List<BookData> values = snapshot.data;
    if(values.isEmpty) {
      return const Text('Nothing is here');
    }
    return ListView.builder(
      itemCount: values.length,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Container(
              alignment: const AlignmentDirectional(0, 0),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListTile(
                leading: Icon(
                  Icons.book,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                title: Text(values[index].title ?? 'No Data',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                subtitle: Text(values[index].author ?? 'No Data',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 20,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookPage(
                              title: values[index].title,
                              book: values[index])));
                },
                contentPadding:
                const EdgeInsetsDirectional.fromSTEB(5, 20, 5, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Favorite Books'),
      body: booksWidget(),
      bottomNavigationBar: const CustomBottomNavigationBarWidget(currentIndex: 1),
    );
  }
}
