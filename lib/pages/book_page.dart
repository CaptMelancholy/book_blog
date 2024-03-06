import 'package:book_blog/utils/book.dart';
import 'package:book_blog/utils/firebase_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookPage extends StatefulWidget {
  final String title;
  final BookData book;
  const BookPage({super.key, required this.title, required this.book});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  bool _isPushing = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _getFavoriteStatus();
  }

  Widget bookWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Text(
                  widget.book.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Text(
                  'Author: ${widget.book.author}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Text(
                  'Description: ${widget.book.description}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            _pushToFavorite();
            _getFavoriteStatus();
          },
          child: Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _isPushing ? CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              ) : Text(
                _isFavorite ? 'Remove from favorite' : 'Add to favorite',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ]
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.book.title, style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary
        ),),
        centerTitle: true,
      ),
      body: bookWidget(context),
    );
  }

  void _pushToFavorite() async {
    setState(() {
      _isPushing = true;
    });
    bool res = false;
    if(_isFavorite) {
      res = await FirebaseDataService.popFavoriteBookFromUser(widget.book);
    } else {
      res = await FirebaseDataService.pushFavoriteBookToUser(widget.book);
    }


    setState(() {
      _isPushing = false;
    });

    if (!res) {

    }
  }

  void _getFavoriteStatus() async {
    bool res = await FirebaseDataService.checkUserFavoriteBook(widget.book);
    if(res) {
      setState(() {
        _isFavorite = true;
      });
    } else {
      setState(() {
        _isFavorite = false;
      });
    }

  }
}