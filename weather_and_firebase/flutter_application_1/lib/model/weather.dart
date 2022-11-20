import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Weather {
  final String city;
  final int degrees;
  AssetImage weatherImage2;
  Color color;
  String description;
  
  
   Weather({
    required this.weatherImage2,
    required this.color,
    required this.city,
    required this.degrees,
    required this.description,
    
    
  });
}
