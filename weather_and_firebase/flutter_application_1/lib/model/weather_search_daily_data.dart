import 'package:flutter/material.dart';

class WeatherSearchDailyData {

  Color colorh;
  final List? mintemp;
  final List? maxtemp;
  AssetImage icon;

  WeatherSearchDailyData({
    required this.colorh,
    required this.icon,
    required this.mintemp,
    required this.maxtemp,
  });
}
