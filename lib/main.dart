import 'package:device_preview/device_preview.dart';
import 'package:ebooknew/pages/bottom_navigation.dart';
import 'package:ebooknew/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  // runApp(MyApp());
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const <Locale>[
      //   Locale('en'),
      //   Locale('ar'),
      //  Locale('YE'),
      // ],
      // locale: const Locale('ar'),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Login(),
    );
  }
}
