import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_file_formats/pages/home_page.dart';
import 'package:save_file_formats/values/app_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColor.blackBackground,
        splashColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      title: 'Save File Formats',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
