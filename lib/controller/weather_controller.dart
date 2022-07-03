import 'package:get/get.dart';
import 'package:weather_app/data/api/weather_api.dart';
import 'package:weather_app/data/entity/weather_entity.dart';

class WeatherController extends GetxController {
  final location = Location().obs;
  final isLoad = false.obs;
  final search = "".obs;
  Rx<Current> current = Current().obs;
  Rx<Forecast> forecast = Forecast().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  void fetchLocation(String search) async {
    final response = await WeatherAPI.instance.getWeather(search: search);
    try {
      if(response.isNotEmpty) {
        isLoad.value = true;
        location.value = response["location"];
        current.value = response["current"];
        forecast.value = response["forecast"];
      }else {
        isLoad.value = false;
      }

    } catch (e) {
      print(e.toString());
    }
  }
  void onRefresh() async {
    final response =  await WeatherAPI.instance.getWeather(search: search.value);
    try {
      if(response != null) {
        isLoad.value = true;
        location.value = response["location"];
        current.value = response["current"];
        forecast.value = response["forecast"];
      }else {
        isLoad.value = false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
