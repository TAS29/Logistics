import 'package:flutter/material.dart';
import 'package:logistics/repo/login_repo.dart';
import 'package:logistics/views/home_page.dart';
import 'package:logistics/views/login_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    if (await LoginRepo().isLoggedIn()) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> HomePage()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
