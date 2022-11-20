import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weather.dart';
import 'package:flutter_application_1/model/weather_daily_data.dart';
import 'package:flutter_application_1/model/weather_display_data.dart';
import 'package:flutter_application_1/model/weather_search_daily_data.dart';
import 'package:flutter_application_1/utils/location.dart';
import 'package:http/http.dart' as http;

const apiKey = '875a50b28b10945e2363d3e6a2bc8be2';
late double? longitude;
late double? latitude;

// Bu sınıf ana ekranda bulunan o günlük hava durumu bilgisini almamızı sağlar.

class WeatherData {
  WeatherData({
    required this.locationData,
  });

  LocationHelper locationData;
  late double currentTemperature;
  late String main;
  late String city;
  late int timeStamp;

  //Bu fonksiyon ile konum bilgisinden aldığımız latitude,longitude
  //..bilgisini kullanarak API den sıcaklık,konum adı(ilçe,şehir vs) ve main(genel hava durumu bilgisi) bilgilerini alırız
  Future<void> getCurrentTemperature() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric"));

    latitude = locationData.latitude;
    longitude = locationData.longitude;
    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        main = currentWeather['weather'][0]["main"];
        city = currentWeather['name'];
      } catch (e) {
        print("API den değer gelmiyor 1 ");
      }
    }
  }

  //Aldığımız main bilgilerini istenen şartlar ile kullanırız.
  WeatherDisplayData getWeatherDisplayData() {
    if (main == 'Rain') {
      return WeatherDisplayData(
        description: "Rainy",
        color: const Color(0xFF181824),
        weatherImage: const AssetImage('assets/images/rainy.jpg'),
      );
    } else if (main == 'Snow') {
      return WeatherDisplayData(
          description: "Snowy",
          color: const Color(0xFF466EA2),
          weatherImage: const AssetImage('assets/images/snowy.jpg'));
    } else if (main == 'Clear') {
      return WeatherDisplayData(
          description: "Sunny",
          color: const Color(0xFFEB9E1C),
          weatherImage: const AssetImage('assets/images/sunny.jpg'));
    } else if (main == 'Clouds') {
      return WeatherDisplayData(
        description: "Cloudy",
        color: const Color(0xFF181824),
        weatherImage: const AssetImage('assets/images/cloudy.jpg'),
      );
    } else {
      return WeatherDisplayData(
          description: "Not Found",
          color: const Color.fromARGB(255, 199, 9, 9),
          weatherImage: const AssetImage('assets/images/null.jpg'));
    }
  }
}

//Ana ekranda bulunan günlük hava durumu bilgisini alırız
class WeatherDaily {
  // ignore: non_constant_identifier_names
  static Future<WeatherDailyData> Daily() async {
    final response = await http.get(Uri.parse(
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,weathercode&daily=weathercode,temperature_2m_max,temperature_2m_min&current_weather=true&timezone=auto"));

    final body = jsonDecode(response.body);

    return getDaily(body);
  }

  //API den alınan değerler Daily() fonksiyonuna gönderilir ve weathercode değerine göre şartlar sağlanır
  static WeatherDailyData getDaily(json) {
    final List maxtemp = json["daily"]["temperature_2m_max"];
    final List mintemp = json["daily"]["temperature_2m_min"];

    final List weathercode = json["daily"]["weathercode"];

    for (var i = 0; i < weathercode.length; i++) {
      print("iii  ${i}");
      print("weathercode ${weathercode[i]}");
      print("Lenght: ${weathercode.length}");
      print(DateTime.now().hour);

      if(DateTime.now().hour >= 19 || DateTime.now().hour <= 5){
        return WeatherDailyData(
              colorh: Colors.black,
              mintemp: mintemp,
              icon: const AssetImage('assets/icons/night.jpg'),
              maxtemp: maxtemp);

      }else{
        if (weathercode[i] < 4) {
        if (DateTime.now().hour >= 19 || DateTime.now().hour <= 5) {
          i = i + 1;
          print("yeni i değeri${i}");
          return WeatherDailyData(
              colorh: Colors.black,
              mintemp: mintemp,
              icon: const AssetImage('assets/icons/night_sunny.jpg'),
              maxtemp: maxtemp);
        } else {
          i = i + 1;

          return WeatherDailyData(
              colorh: const Color(0xFFEB9E1C),
              mintemp: mintemp,
              icon: const AssetImage('assets/icons/sunny.jpg'),
              maxtemp: maxtemp);
        }
      } else if (4 < weathercode[i] && weathercode[i] < 45) {
        if (DateTime.now().hour >= 19) {
          i = i + 1;
          return WeatherDailyData(
              colorh: Colors.black,
              icon: const AssetImage('assets/icons/night_cloudy.jpg'),
              mintemp: mintemp,
              maxtemp: maxtemp);
        } else {
          i = i + 1;
          return WeatherDailyData(
              colorh: const Color(0xFF181824),
              icon: const AssetImage('assets/icons/cloudy.jpg'),
              mintemp: mintemp,
              maxtemp: maxtemp);
        }
      } else if (45 < weathercode[i] && weathercode[i] < 65) {
        i = i + 1;
        return WeatherDailyData(
            colorh: const Color(0xFF181824),
            icon: const AssetImage('assets/icons/rainy.jpg'),
            mintemp: mintemp,
            maxtemp: maxtemp);
      } else if (65 < weathercode[i] && weathercode[i] < 100) {
        i = i + 1;
        print("weather code ${weathercode}");
        return WeatherDailyData(
            colorh: const Color(0xFF466EA2),
            icon: const AssetImage('assets/icons/snowy.jpg'),
            mintemp: mintemp,
            maxtemp: maxtemp);
      } else {
        i = i + 1;
        return WeatherDailyData(
            colorh: Colors.red,
            maxtemp: maxtemp,
            mintemp: mintemp,
            icon: const AssetImage('assets/images/null.jpg'));
      }
      }

      print("i:${i}");
    }
    return getDaily(json);
  }
}



// İstenilen bölgenin hava durumu bilgisine ulaşılan kod
class WeatherApi {
  late double currentTemperature;
  late String city;

  // Bu fonsiyon ile istenilen şehir sorgulanır
  static Future<List<String>> searchCities({required String query}) async {
    final limit = 3;
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=$limit&appid=$apiKey'));

    final body = json.decode(response.body);

    return body.map<String>((json) {
      final city1 = json['name'];
      final country = json['country'];

      return '$city1, $country';
    }).toList();
  }

  // Bu fonsiyon ile sorgulanmış şehirin adını kullanarak API sorgularız
  static Future<Weather> getWeather({required String city}) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey'));

    final body = json.decode(response.body);

    return convert(body);
  }

  //Bu fonsiyon ile sorgulanmış API den sıcaklık,main ve latlitude longitude değerlerine ulaşırız ve şartlarla kullanırız.
  static Future<Weather> convert(json) async {
    final main = json['weather'].first['main'];
    final city = json['name'];
    final int degrees = (json['main']['temp']).toInt();
    latitude = json["coord"]["lat"];
    longitude = json["coord"]["lon"];

    print('main: $main');
    print("LOGİTUDE WEATHERAPİ${longitude} ${latitude}");

    if (main == 'Rain') {
      return Weather(
        description: "Rainy",
        city: city,
        degrees: degrees,
        color: const Color(0xFF181824),
        weatherImage2: const AssetImage('assets/images/rainy.jpg'),
      );
    } else if (main == 'Snow') {
      return Weather(
          description: "Snowy",
          city: city,
          degrees: degrees,
          color: const Color(0xFF466EA2),
          weatherImage2: const AssetImage('assets/images/snowy.jpg'));
    } else if (main == 'Clear') {
      return Weather(
          description: "Sunny",
          city: city,
          degrees: degrees,
          color: const Color(0xFFEB9E1C),
          weatherImage2: const AssetImage('assets/images/sunny.jpg'));
    } else if (main == 'Clouds') {
      return Weather(
        description: "Cloudy",
        city: city,
        degrees: degrees,
        color: const Color(0xFF181824),
        weatherImage2: const AssetImage('assets/images/rainy.jpg'),
      );
    } else {
      return Weather(
          description: "Not Found",
          city: city,
          degrees: degrees,
          color: const Color.fromARGB(255, 199, 9, 9),
          weatherImage2: const AssetImage('assets/images/null.jpg'));
    }
  }
}

//İstenilen şehirdeki 7 günlük hava durumu bilgisine ulaşırız.
class WeatherSearchDaily {
  // ignore: non_constant_identifier_names
  static Future<WeatherSearchDailyData> SearchDaily() async {
    final response = await http.get(Uri.parse(
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,weathercode&daily=weathercode,temperature_2m_max,temperature_2m_min&current_weather=true&timezone=auto"));

    final body = jsonDecode(response.body);

    return getSearchDaily(body);
  }

  static WeatherSearchDailyData getSearchDaily(json) {
    final List maxtemp = json["daily"]["temperature_2m_max"];
    final List mintemp = json["daily"]["temperature_2m_min"];
    final List weathercode = json["daily"]["weathercode"];

    for (var i = 0; i < weathercode.length; i++) {
      if (weathercode[i] < 4) {
        if (DateTime.now().hour >= 19) {
          return WeatherSearchDailyData(
              colorh: Colors.black,
              mintemp: mintemp,
              icon: const AssetImage('assets/icons/night_sunny.jpg'),
              maxtemp: maxtemp);
        } else {
          return WeatherSearchDailyData(
              colorh: const Color(0xFFEB9E1C),
              mintemp: mintemp,
              icon: const AssetImage('assets/icons/sunny.jpg'),
              maxtemp: maxtemp);
        }
      } else if (4 < weathercode[i] && weathercode[i] < 45) {
        if (DateTime.now().hour >= 19) {
          return WeatherSearchDailyData(
              colorh: Colors.black,
              icon: const AssetImage('assets/icons/night_cloudy.jpg'),
              mintemp: mintemp,
              maxtemp: maxtemp);
        } else {
          return WeatherSearchDailyData(
              colorh: const Color(0xFF181824),
              icon: const AssetImage('assets/icons/cloudy.jpg'),
              mintemp: mintemp,
              maxtemp: maxtemp);
        }
      } else if (45 < weathercode[i] && weathercode[i] < 65) {
        return WeatherSearchDailyData(
            colorh: const Color(0xFF181824),
            icon: const AssetImage('assets/icons/rainy.jpg'),
            mintemp: mintemp,
            maxtemp: maxtemp);
      } else if (65 < weathercode[i] && weathercode[i] < 100) {
        return WeatherSearchDailyData(
            colorh: const Color(0xFF466EA2),
            icon: const AssetImage('assets/icons/snowy.jpg'),
            mintemp: mintemp,
            maxtemp: maxtemp);
      } else {
        return WeatherSearchDailyData(
            colorh: Colors.red,
            maxtemp: maxtemp,
            mintemp: mintemp,
            icon: const AssetImage('assets/images/null.jpg'));
      }
    }
    return getSearchDaily(json);
  }
}
