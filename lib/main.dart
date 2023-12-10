import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logistics/repo/get_search_result.dart';
import 'package:logistics/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providing the GetSearchResult instance using ChangeNotifierProvider
        ChangeNotifierProvider(create: (context) => GetSearchResult()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Logistics',
        // You can customize the theme further by defining your ThemeData
        theme: ThemeData.dark(),
        // Starting with a SplashScreen, consider adjusting the navigation flow based on your app's structure.
        home: Splash(),
      ),
    );
  }
}
