import 'package:get/get.dart';
import 'package:weather_app/controller/country_controller.dart';
import 'package:weather_app/controller/weather_controller.dart';

class Dependency extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => WeatherController());
   Get.lazyPut(() => CountryController());
  }

}