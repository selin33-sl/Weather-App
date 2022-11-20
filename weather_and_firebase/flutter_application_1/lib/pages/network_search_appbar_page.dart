import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/weather_api.dart';
import 'package:flutter_application_1/model/weather.dart';
import 'package:flutter_application_1/model/weather_search_daily_data.dart';
import 'package:flutter_application_1/pages/search_daily.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:intl/intl.dart';

class CitySearch extends SearchDelegate<String> {
  WeatherSearchDailyData? weatherSearchDailyData;

  // Seach ekranında text temizlemek için kullanılan Widget
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, "null1");
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

//Search ekranından bir önceki sayfaya gitmek için kullanılan Widget
  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, "null2"),
      );

  //Aranan şehrin adı ile API değerlerine ulaşıp ulaşmadığımız anlamamızı sağlayan,
  //..ulaşıldığı takdirde gerekli Widget a yönlendirilen Widget
  @override
  Widget buildResults(BuildContext context) => FutureBuilder<Weather>(
        future: WeatherApi.getWeather(city: query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Container(
                  color: const Color.fromARGB(255, 203, 40, 4),
                  alignment: Alignment.center,
                  child: const Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                );
              } else {
                return buildResultSuccess(snapshot.data!);
              }
          }
        },
      );

  //Aranan şehrin adının doğru sorgulanıp sorgulanmadığı bildiren,
  //..gelen cevaba göre ilgili Widgetlere yönlendirme sağlayan Widget
  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.black,
        child: FutureBuilder<List<String>>(
          future: WeatherApi.searchCities(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data!.isEmpty) {
                  return buildNoSuggestions();
                } else {
                  return buildSuggestionsSuccess(snapshot.data!);
                }
            }
          },
        ),
      );

  //Arama ekranında arama yapmaya başlamadan önce bizi karşılan ekran bilgilendirmesi
  Widget buildNoSuggestions() => const Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      );

  //Şehir sorgusu başarılı olduğu taktirde suggestion değerleri listelenir
  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;
            },
            leading: const Icon(Icons.location_city),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  //Sorgulanan şehir başarılı olduğu taktirde çalışacak olan Widget
  Widget buildResultSuccess(Weather weather) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: weather.color),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(color: weather.color),
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
                              "${DateTime.now().year.toString()}/" +
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
                              weather.city,
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
                      left: 37, right: 37, top: 13, bottom: 34),
                  child: Container(
                    //padding: const EdgeInsets.only(left:35,right: 35 ),
                    constraints: const BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: weather.weatherImage2, fit: BoxFit.cover),
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
                                  color: weather.color,
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
                                          '${weather.degrees}',
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
                                    Text(weather.description, style: style3())
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
                      decoration: BoxDecoration(color: weather.color),
                      child: const SearchDaily(),
                    ),
                  ))
            ],
          ),
        )
      ],
    )));
  }
}
