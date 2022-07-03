import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/view/constants/color.dart';
import 'package:weather_app/view/screen/home/home_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/view/screen/main_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => Get.toNamed("/main-view"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.description,
      body: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
            color: UIColors.white, size: 30),
      ),
    );
  }
}
