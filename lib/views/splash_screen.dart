import 'package:flutter/material.dart';
import 'package:logistics/auth/local_auth.dart';
import 'package:logistics/auth/login_repo.dart';
import 'package:logistics/constants/theme_constants.dart';
import 'package:logistics/data/local/shared_pref_data_source.dart';
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
    final isAuthenticated = await LocalAuth().authenticate();

    if (isAuthenticated) {
      if (await SharedPrefDataSource().isLoggedIn()) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomePage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Biometrics Authentication Failed!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.white,
      body: Center(
      child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(3),
              /** FlutterLogo Widget **/
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlutterLogo(
                    size: 200,
                  ),
                  SizedBox(height: 10,),
                  Text("Neosurge",style: TextStyle(fontSize: 20,color: Colors.red),),
                  SizedBox(height: 10,),
                ],
              ), //FlutterLogo
            ),
    ),
    );
  }
}
