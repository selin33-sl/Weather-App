import 'package:flutter/cupertino.dart';

class WeatherDailyData {

  Color colorh;
  final List? mintemp;
  final List? maxtemp;
  AssetImage icon;

  WeatherDailyData({
    required this.colorh,
    required this.icon,
    required this.mintemp,
    required this.maxtemp,
  });
}
