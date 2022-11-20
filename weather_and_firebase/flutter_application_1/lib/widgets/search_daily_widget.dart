import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weather_search_daily_data.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SearchDailyWidget extends StatefulWidget {
  WeatherSearchDailyData weatherSearchDailyData;
  List? maxtemp;
  List? mintemp;
  AssetImage icon;
  Color? colorh;
  SearchDailyWidget({
    Key? key,
    required this.colorh,
    required this.icon,
    required this.mintemp,
    required this.maxtemp,
    required this.weatherSearchDailyData,
  }) : super(key: key);

  @override
  State<SearchDailyWidget> createState() => _DenemeState();
}

class _DenemeState extends State<SearchDailyWidget> {

  
   void updateDisplayInfo(
    WeatherSearchDailyData weatherSearchDailyData,
  ) {
    setState(() {
      widget.maxtemp = weatherSearchDailyData.maxtemp;
      widget.mintemp=weatherSearchDailyData.mintemp;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(
      widget.weatherSearchDailyData,
    );
  }

  
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('EEEEE');
    final items = List.generate(7, (i) {
      DateTime date = DateTime.now();
      return formatter.format(date.add(Duration(days: i)));
    });

    List<DailySearchWeather> allDay = List.generate(
      7,
      (index) => DailySearchWeather(
          colorh: widget.colorh,
          day: items[index],
          icon: widget.icon,
          degreemax: widget.maxtemp![index],
          degreemin: widget.mintemp![index]),
    );
    return Center(
      child: ListView(
        children: allDay
            .map((DailySearchWeather dailySearchWeather) =>
                InkWell(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dailySearchWeather.day,
                            style: style4(),
                          ),
                          Center(
                              child: Image(
                                  image: dailySearchWeather
                                      .icon)),
                          Text(
                              "${dailySearchWeather.degreemax}/${dailySearchWeather.degreemin}",
                              style: style4())
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      )
                    ],
                  ),
                  onTap: () {
                    print(
                        "DEGREEMAX ${dailySearchWeather.degreemax}");
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             HourlyScreenWidget(
                    //               hourTemp: [],
                    //               colorh:dailyWeather.colorh,
                    //               day: dailyWeather.day,
                    //               icon: dailyWeather.icon,
                    //               maxtemp: dailyWeather.degreemax,
                    //               mintemp: dailyWeather.degreemin,

                    //             )));
                  },
                ))
            .toList(),
      ),
    );
  }
}
class DailySearchWeather {
  final String day;
  final AssetImage icon;
  final double degreemax;
  final double degreemin;
  final Color? colorh;

  DailySearchWeather({
    required this.colorh,
    required this.day,
    required this.icon,
    required this.degreemax,
    required this.degreemin,
  });
}