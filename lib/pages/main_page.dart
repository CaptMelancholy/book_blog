import 'package:book_blog/utils/book.dart';
import 'package:book_blog/utils/firebase_data_service.dart';
import 'package:book_blog/widgets/app_bar.dart';
import 'package:book_blog/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

import 'book_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget booksWidget() {
    return FutureBuilder(
      future: FirebaseDataService.getAllBooks(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Text('Loading... Please Wait...');
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
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              alignment: const AlignmentDirectional(0, 0),

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
                              book: values[index]))
                  );
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
      appBar: const CustomAppBar(title: 'Book blog'),
      body: booksWidget(),
      bottomNavigationBar: const CustomBottomNavigationBarWidget(currentIndex: 0),
    );
  }
}
