import 'package:flutter/material.dart';
import 'package:tracking_app/home_page.dart';
import 'package:tracking_app/login_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}
