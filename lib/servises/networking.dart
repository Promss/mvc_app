import 'package:clima_mvc/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.statusCode);
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed request');
    }
  }
}
