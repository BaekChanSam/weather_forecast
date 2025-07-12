import 'package:get/get.dart';
import '../../../data/weather_model.dart';
import '../../../data/weather_provider.dart';

class HomeController extends GetxController {
  final weatherProvider = WeatherProvider();

  final weather = Rx<WeatherModel?>(null);
  final isLoading = false.obs;

  final cityName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData({String city = 'Seoul'}) async {
    try {
      isLoading.value = true;
      final data = await weatherProvider.fetchWeather(city);
      final model = WeatherModel.fromJson(data);
      weather.value = model;
      cityName.value = model.cityName ?? 'Unknown';
    } catch (e) {
      Get.snackbar('에러', e.toString());
    } finally {
      isLoading.value = false;
    }
    print('weather의 값을 테스트 합니다 ${weather.value}');
  }
}
