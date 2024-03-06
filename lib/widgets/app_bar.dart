import 'package:book_blog/pages/book_page.dart';
import 'package:book_blog/utils/firebase_auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_blog/pages/sing_in_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  void redirectToLogIn(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SingInPage()),
        (route) => false);
  }

  List<Widget>? signOutButton(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          color: Theme.of(context).colorScheme.onPrimary,
          tooltip: 'Sign out',
          onPressed: () {
            FirebaseAuthService.signOut();
            redirectToLogIn(context);
          },
        ),
      ];
    }
    return <Widget>[];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
      actions: signOutButton(context),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
