import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logistics/constants/constants.dart'; // Assuming you have a file named constants.dart
import 'package:logistics/data/local/shared_pref_data_source.dart';
import 'package:logistics/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {

  // Method to handle the login process
  Future<void> login(_formKey, emailController, passwordController, context) async {
    if (_formKey.currentState!.validate()) {
      try {
        // Attempt to sign in with Firebase authentication
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Set the logged-in status to true and navigate to the home page
        await SharedPrefDataSource().setLoggedIn(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        // Set the logged-in status to false in case of login failure
        await SharedPrefDataSource().setLoggedIn(false);

        // Handle different authentication exceptions and show appropriate error messages
        String _error = "";
        if (e.code == 'wrong-password') {
          _error = 'The password is incorrect. Please try again.';
        } else if (e.code == 'user-not-found') {
          _error = 'There is no user associated with this email. The user may have been deleted.';
        } else if (e.code == 'invalid-email') {
          _error = 'The email is not valid. Please check and try again.';
        } else {
          _error = 'Incorrect Username/Password. Please try again.';
        }

        // Show a SnackBar with the error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_error),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
