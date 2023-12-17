import 'package:flutter/material.dart';
import 'package:logistics/auth/login_repo.dart';
import 'package:logistics/constants/theme_constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeConstants.red,
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: ThemeConstants.black,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email input field
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Invalid email address';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: ThemeConstants.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: ThemeConstants.white),
              ),
              SizedBox(height: 16.0),
              // Password input field
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: ThemeConstants.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
                style: TextStyle(color: ThemeConstants.white),
              ),
              SizedBox(height: 32.0),
              // Login button
              ElevatedButton(
                onPressed: () async {
                  // Call login function from the repository
                  await LoginRepo().login(_formKey, emailController, passwordController, context);
                },
                style: ElevatedButton.styleFrom(
                  primary: ThemeConstants.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16.0, color: ThemeConstants.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
