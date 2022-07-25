class WeatherModel {
  double _temp;
  String _city;
  String _description;
  double _windSpeed;
  int _humidity;

  double get temp => _temp;
  String get city => _city;
  String get description => _description;
  double get windSpeed => _windSpeed;
  int get humidity => _humidity;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : _temp = json['main']['temp'],
        _city = json['name'],
        _description = json['weather'][0]['main'],
        _windSpeed = json['wind']['speed'],
        _humidity = json['main']['humidity'];
}

// class WeatherData {
//   final List<WeatherModel> data = [];
//   WeatherData.fromJson(Map<String, dynamic> jsonItems) {
//     for (var jsonItem in jsonItems[1]()) {
//       data.add(WeatherModel.fromJson(jsonItem));
//     }
//   }
// }

abstract class WeatherResult {}

class ResultFailure extends WeatherResult {
  final String error;
  ResultFailure(this.error);
}

class ResultSuccess extends WeatherResult {
  final WeatherModel weatherModel;
  ResultSuccess(this.weatherModel);
}

class ResultLoading extends WeatherResult {
  ResultLoading();
}
