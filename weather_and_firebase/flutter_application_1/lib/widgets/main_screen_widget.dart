// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter_application_1/model/weather_daily_data.dart';
import 'package:flutter_application_1/pages/network_search_appbar_page.dart';
import 'package:flutter_application_1/pages/profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/weather_api.dart';
import 'package:flutter_application_1/styles/styles.dart';

class MainScreenWidget extends StatefulWidget {
  WeatherData weatherData;
  WeatherDailyData weatherDailyData;
  AssetImage backgroundImage;
  int? temperature;
  String description;
  String city;
  Color color;
  //Widget widget;
  final context;
  List? maxtemp;
  List? mintemp;
  AssetImage icon;
  Color? colorh;

  MainScreenWidget({
    Key? key,
    required this.colorh,
    required this.icon,
    required this.weatherData,
    required this.backgroundImage,
    required this.temperature,
    required this.description,
    required this.city,
    required this.color,
    required this.weatherDailyData,
    //required this.widget,
    required this.context,
    required this.maxtemp,
    required this.mintemp,
  }) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  void updateDisplayInfo(
    WeatherDailyData weatherDailyData,
  ) {
    setState(() {
      widget.maxtemp = weatherDailyData.maxtemp;
      widget.mintemp = weatherDailyData.mintemp;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(
      widget.weatherDailyData,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('EEEEE');
    final items = List.generate(7, (i) {
      DateTime date = DateTime.now();
      return formatter.format(date.add(Duration(days: i)));
    });

    List<DailyWeather> allDay = List.generate(
      7,
      (index) => DailyWeather(
          colorh: widget.colorh,
          day: items[index],
          icon: widget.icon,
          degreemax: widget.maxtemp![index],
          degreemin: widget.mintemp![index]),
    );

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 65),
            child: SafeArea(
                child: Container(
              decoration: BoxDecoration(
                color: widget.color,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                city: widget.city,
                              )));

                      //  Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => ProfileScreen(
                      //             city: widget.city,
                      //           )));
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => Get_Data(
                      //       city: widget.city,
                      //       text1: 'email',
                      //        text2: 'password',
                      //         text3: 'name',
                      //          text4: 'text4')
                      //         )
                      //         );
                    },
                    icon: const Icon(Icons.person),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showSearch(context: context, delegate: CitySearch());
                      // do something
                    },
                  )
                ],
              ),
            ))),
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: widget.color),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(color: widget.color),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat("EEEEE")
                                      .format(DateTime.now())
                                      .toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${DateTime.now().year.toString()}/"
                                          "${DateTime.now().month.toString()}/" +
                                      DateTime.now().day.toString(),
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                Text(
                                  widget.city,
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 37,
                        right: 37,
                        top: 13,
                      ),
                      child: Container(
                        //padding: const EdgeInsets.only(left:35,right: 35 ),
                        constraints: const BoxConstraints.expand(),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: widget.backgroundImage, fit: BoxFit.cover),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              left: 108,
                              right: 108,
                              top: 30,
                              child: GestureDetector(
                                onTap: () {
                                  debugPrint("Butona tıklandı");
                                },
                                child: Container(
                                    width: 112,
                                    height: 116,
                                    decoration: BoxDecoration(
                                      color: widget.color,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${widget.temperature}",
                                              style: style2(),
                                            ),
                                            const Text(
                                              "°",
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Text(widget.description,
                                            style: style3())
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(color: widget.color),
                          child: Center(
                            child: ListView(
                              children: allDay
                                  .map((DailyWeather dailyWeather) => Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                dailyWeather.day,
                                                style: style4(),
                                              ),
                                              Center(
                                                  child: Image(
                                                      image:
                                                          dailyWeather.icon)),
                                              Text(
                                                  "${dailyWeather.degreemax}/${dailyWeather.degreemin}",
                                                  style: style4())
                                            ],
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                          )
                                        ],
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        )));
  }
}

class DailyWeather {
  final String day;
  final AssetImage icon;
  final double degreemax;
  final double degreemin;
  final Color? colorh;

  DailyWeather({
    required this.colorh,
    required this.day,
    required this.icon,
    required this.degreemax,
    required this.degreemin,
  });
}
