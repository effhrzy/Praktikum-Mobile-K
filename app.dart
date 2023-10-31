import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/view/pages/home_page.dart';
import 'package:mikan/view/pages/settings.dart';
import 'package:mikan/view/pages/webview.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      getPages: [
        GetPage(
          name: '/homePage',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/settings',
          page: () => const SettingsPage(),
        ),
        GetPage(name: '/bookmark', page: () => BookWebView())
      ],
    );
  }
}
