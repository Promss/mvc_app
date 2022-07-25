import 'package:clima_mvc/models/weather_model.dart';
import 'package:clima_mvc/servises/networking.dart';
import 'package:mvc_application/controller.dart';
import '../servises/location.dart';

class WeatherController extends ControllerMVC {
  late double lat;
  late double lon;

  WeatherController();

  WeatherResult currentState = ResultLoading();

  void init() async {
    try {
      Location location = Location();
      await location.getCurrentPosition();
      lat = location.latitude!;
      lon = location.longitude!;
      print(location.latitude);
      print(location.longitude);
      getData(lat, lon);
    } catch (e) {
      setState(() => currentState = ResultFailure("Failed to connect"));
    }
  }

  void getData(double? lat, double? lon) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=cd4cf7b560ffc38e1d1623bbebe0ec93#');

    final weatherData = await networkHelper.getData();

    setState(() => currentState = ResultSuccess(weatherData));
  }
}
