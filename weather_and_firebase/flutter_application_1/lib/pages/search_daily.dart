import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/weather_api.dart';
import 'package:flutter_application_1/model/weather_search_daily_data.dart';
import 'package:flutter_application_1/widgets/search_daily_widget.dart';

class SearchDaily extends StatefulWidget {
  const SearchDaily({ Key? key }) : super(key: key);

  @override
  State<SearchDaily> createState() => _SearchDailyState();
}

class _SearchDailyState extends State<SearchDaily> {

  //Aranan şehir sorgusunun yapıldığı API den latitude longitude konum bilgileri alınır,
  //..günlük hava durumu bilgilerini sağlayan API ile kullanılarak günlük sıcaklık değerlerine ulaşılır.
  

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<WeatherSearchDailyData>(
        future: WeatherSearchDaily.SearchDaily(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child:  CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Container(
                  color: const Color.fromARGB(255, 203, 40, 4),
                  alignment: Alignment.center,
                  child: const Text(
                    'Something went wrong!',
                    style:  TextStyle(fontSize: 28, color: Colors.white),
                  ),
                );
              } else {
                return buildResultSuccess(snapshot.data!);
              }
          }
        },
      );
  }

  Widget buildResultSuccess(WeatherSearchDailyData weatherSearchDailyData,){
  

    return SearchDailyWidget(
        colorh: weatherSearchDailyData.colorh, 
        icon: weatherSearchDailyData.icon, 
        mintemp: weatherSearchDailyData.mintemp,
         maxtemp: weatherSearchDailyData.maxtemp,
          weatherSearchDailyData: weatherSearchDailyData);
  


  }
}