import 'package:book_blog/pages/main_page.dart';
import 'package:book_blog/pages/sing_in_page.dart';
import 'package:book_blog/utils/firebase_auth_service.dart';
import 'package:book_blog/utils/firebase_data_service.dart';
import 'package:book_blog/utils/user.dart';
import 'package:book_blog/widgets/app_bar.dart';
import 'package:book_blog/widgets/form_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {

  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _favoriteBooksController = TextEditingController();
  final TextEditingController _favoriteAuthorsController = TextEditingController();
  final TextEditingController _favoriteJanarsController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _aboutMeController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _ageController.dispose();
    _favoriteBooksController.dispose();
    _favoriteAuthorsController.dispose();
    _favoriteJanarsController.dispose();
    super.dispose();
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sign up'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 30,
                ),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _nameController,
                  hintText: "Name",
                  isPasswordField: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _surnameController,
                  hintText: "Surname",
                  isPasswordField: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _aboutMeController,
                  hintText: "About me",
                  isPasswordField: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _ageController,
                  hintText: "Age",
                  isPasswordField: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if(!isNumeric(value)) {
                      return 'Please enter number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _favoriteAuthorsController,
                  hintText: "Favorite Authors",
                  isPasswordField: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _favoriteBooksController,
                  hintText: "Favorite Books",
                  isPasswordField: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _favoriteJanarsController,
                  hintText: "Favorite Janars",
                  isPasswordField: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _signUp(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isSigning ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,) : Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const SingInPage()),
                              (route) => false,
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _signUp(BuildContext context) async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;
    String about =_aboutMeController.text;
    String name =_nameController.text;
    String surname =_surnameController.text;
    String age =_ageController.text;
    String favorite_books =_favoriteBooksController.text;
    String favorite_authors =_favoriteAuthorsController.text;
    String favorite_janars =_favoriteJanarsController.text;
    if(!email.isNotEmpty && !password.isNotEmpty) {
      return;
    }


    UserData userData = UserData(email, name, surname, about, int.parse(age), favorite_authors, favorite_books, favorite_janars);
    User? user = await _auth.signUpWithEmailAndPassword(context, email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      var id = user.uid;
      FirebaseDataService.createDatabaseUser(id, userData);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainPage())
      );
    }
  }
}