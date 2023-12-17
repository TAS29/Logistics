import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/bloc/bloc_observer.dart';
import 'package:logistics/bloc/fintech_bloc.dart';
import 'package:logistics/bloc/search_result_bloc.dart';
import 'package:logistics/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchResultBloc()),
        BlocProvider(create: (context) => FintechBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Neosurge',
        // You can customize the theme further by defining your ThemeData
        theme: ThemeData.dark(),
        // Starting with a SplashScreen, consider adjusting the navigation flow based on your app's structure.
        home: Splash(),
      ),
    );
  }
}
