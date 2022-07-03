import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/data/dependency/dependency.dart';
import 'package:weather_app/view/screen/detail/weather_hour_detail.dart';
import 'package:weather_app/view/screen/home/home_view.dart';
import 'package:weather_app/view/screen/main_view.dart';
import 'package:weather_app/view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: _createTransitionBuilder,
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      initialBinding: Dependency(),
      getPages: [
       GetPage(name: "/", page: () => const SplashView()),
       GetPage(name: "/main-view", page: () => const MainView()),
       GetPage(name: "/home-view", page: () => const HomeView()),],
    );
  }
}
TransitionBuilder get _createTransitionBuilder {
  return (context, Widget? child) {
    double textSize = MediaQuery.of(context).textScaleFactor;
    double textScaleFactor = 1.0;
    if (textSize > textScaleFactor) {
      textScaleFactor = textSize;
    }
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaleFactor: textScaleFactor),
        child: child!);
  };
}

