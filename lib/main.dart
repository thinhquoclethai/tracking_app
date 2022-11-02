import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/color_schema.dart';
import 'package:tracking_app/login_page.dart';

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => const App(), // Wrap your app
      ),
    );

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking app',
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const LoginPage(),
    );
  }
}
