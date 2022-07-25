import 'package:clima_mvc/controllers/controller.dart';
import 'package:clima_mvc/models/weather_model.dart';
import 'package:clima_mvc/servises/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../utilities/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC {
  WeatherController? _controller;

  _HomeState() : super(WeatherController()) {
    _controller = controller as WeatherController;
  }

  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    _controller?.init();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMMd('en');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildCheck());
  }

  Widget _buildCheck() {
    final state = _controller?.currentState;
    if (state is ResultLoading) {
      return const Center(
          child: SpinKitThreeBounce(
        color: Color.fromARGB(255, 0, 0, 0),
        size: 20.0,
      ));
    } else if (state is ResultFailure) {
      return Center(
          child: Text(state.error,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.red)));
    } else {
      final city = (state as ResultSuccess).weatherModel.city;
      final descriprion = (state).weatherModel.description;
      final kelvinTemp = (state).weatherModel.temp;
      final temp = kelvinTemp.toInt() - 273;
      final windSpeed = (state).weatherModel.windSpeed;
      final humidity = (state).weatherModel.humidity;
      return _buildContent(city, temp, descriprion, windSpeed, humidity);
    }
  }

  Widget _buildContent(String city, int temp, String description,
      double windSpeed, int humidity) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment(1.0, -1.0),
                    image: ExactAssetImage('assets/vector.png')),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: <Color>[Color(0xFF47BFDF), Color(0xFF4A91FF)],
                )),
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 40),
                          child: Image.asset(
                            'assets/map-pin.png',
                            scale: 0.8,
                          )),
                      Text(city, style: cityTextStyle)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: description == 'Clear'
                      ? Image.asset(
                          'assets/sun.png',
                          width: 165,
                          height: 165,
                        )
                      : description == 'Clouds'
                          ? Image.asset('assets/cloud.png')
                          : description == 'Rain'
                              ? Image.asset('assets/rain.png')
                              : description == 'Snow'
                                  ? Image.asset('assets/snow.png')
                                  : Image.asset(''),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 31),
                  constraints: const BoxConstraints(
                    minHeight: 300.0,
                    minWidth: 353.0,
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 2,
                          color: const Color(0xFFFFFFFF).withOpacity(0.3))),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                            'Today, ' + dateFormat.format(DateTime.now()),
                            style: currentDayTextStyle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 30),
                        child: Text(
                          '$temp°',
                          style: tempTextStyle,
                        ),
                      ),
                      Text(
                        description,
                        style: cityTextStyle,
                      ),
                      SizedBox(
                        width: 210,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Image.asset(
                                  'assets/wind.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                            Text('Wind', style: currentDayTextStyle),
                            Text('|', style: currentDayTextStyle),
                            Text('$windSpeed km/h', style: currentDayTextStyle)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 210,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Image.asset('assets/humidity.png'),
                              ),
                            ),
                            Text('Humidity', style: currentDayTextStyle),
                            Text('|', style: currentDayTextStyle),
                            Text('$humidity%', style: currentDayTextStyle)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            )));
  }
}
