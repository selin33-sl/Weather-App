import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/weather_api.dart';
import 'package:flutter_application_1/model/weather_daily_data.dart';
import 'package:flutter_application_1/model/weather_display_data.dart';
import 'package:flutter_application_1/widgets/main_screen_widget.dart';


class MainScreen extends StatefulWidget {
  final WeatherData weatherData;
  
 

  const MainScreen({Key? key, required this.weatherData, }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime now = DateTime.now();
  late List day;
  int? temperature;
  late AssetImage backgroundImage;
  late String city;
  late Color color;
  late String description;
   Color? colorh;
  

  

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      
      city = weatherData.city;
      temperature = weatherData.currentTemperature.round();
     WeatherDisplayData weatherDisplayData =weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      color = weatherDisplayData.color;
      description=weatherDisplayData.description;
    });
  }

  //Anlık değişimler kontrol edilir.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }  

  //Günlük verilerin çekilmesi sorgulanır, başırılı olduğu taktirde ilgili Widget a yönlendirilir.
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<WeatherDailyData>(
        future: WeatherDaily.Daily(),
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


 
 Widget buildResultSuccess(WeatherDailyData weatherDailyData,){
  

    return MaterialApp(
      home: MainScreenWidget(
        mintemp: weatherDailyData.mintemp,
        icon: weatherDailyData.icon,
        weatherDailyData: weatherDailyData,
        maxtemp: weatherDailyData.maxtemp,
       
        description: description,
        temperature: temperature, 
        backgroundImage: backgroundImage,
         city: city, 
         color: color,
         context: context, 
        
        // widget: buildResults(context), 
         weatherData: widget.weatherData, 
         colorh: colorh, ),
    );

  


  }
//  @override
//   Widget buildResults(BuildContext context) => FutureBuilder<WeatherDailyData>(
//         future: WeatherDaily.Daily(),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return const Center(child:  CircularProgressIndicator());
//             default:
//               if (snapshot.hasError) {
//                 print("DAY :  ${day}");
//                 print(snapshot.hasError);
//                 return Container(
//                   color: const Color.fromARGB(255, 203, 40, 4),
//                   alignment: Alignment.center,
//                   child: const Text(
//                     'Something went wrong!',
//                     style:  TextStyle(fontSize: 28, color: Colors.white),
//                   ),
//                 );
//               } else {
//                 print("ELSE : ${snapshot.data!}");
//                 print("DAY :  ${day}");
//                 return Text("${snapshot.data!}");
//               }
//           }
//         },
//       );


}
//  class CustomSearchDelegate extends SearchDelegate{
// List<String> searchTerms=[
//   'aa',
//   'bb',
//   'cc',

// ];

//   @override
//   List<Widget>buildActions(BuildContext context){
//     return[
//       IconButton(onPressed: (){
//         query = '';
//       }, icon: Icon(Icons.clear))
//     ];
//   }
  
//   @override
//   Widget buildResults(BuildContext context){
//     List<String>matchQuery=[];
//     for(var fruit in searchTerms){
//       if(fruit.toLowerCase().contains(query.toLowerCase())){
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context,index){
//         var result=matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }

//   @override
//   Widget buildLeading(BuildContext context){
//     return(IconButton(onPressed: (){
//         close(context, null);
//       }, icon: Icon(Icons.arrow_back)));
      
    
//   }

//   @override
//   Widget buildSuggestions(BuildContext context){
//     List<String>matchQuery=[];
//     for(var fruit in searchTerms){
//       if(fruit.toLowerCase().contains(query.toLowerCase())){
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context,index){
//         var result=matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }
  

//  }


 // import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/profile_screen.dart';
// import 'package:flutter_application_1/styles/styles.dart';
// import 'package:flutter_application_1/utils/weather.dart';
// import 'package:animation_search_bar/animation_search_bar.dart';

// class MainScreen extends StatefulWidget {
//   final weatherData weatherData;

//   MainScreen({Key? key, required this.weatherData}) : super(key: key);

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   DateTime now = DateTime.now();

//   int? temperature;
//   late AssetImage backgroundImage;
//   late String city;
//   Color? color;

//   // Future<void> GetAddressFromLatLong(Position position)async {
//   //   List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
//   //   print(placemarks);
//   //   Placemark place = placemarks[0];
//   //   city = '${place.locality}, ${place.country}' ;
   
//   // }

//   void updateDisplayInfo(weatherData weatherData) {
//     setState(() {
//       print("***********************************CITYYYYYYYYYYY"+city);
//       city = weatherData.city;

//       temperature = weatherData.currentTemperature.round();
//       WeatherDisplayData weatherDisplayData =
//           weatherData.getWeatherDisplayData();
//       backgroundImage = weatherDisplayData.weatherImage;
//       color = weatherDisplayData.color;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     updateDisplayInfo(widget.weatherData);
//   }

//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: PreferredSize(
//             preferredSize: const Size(double.infinity, 65),
//             child: SafeArea(
//                 child: Container(
//               decoration: BoxDecoration(
//                 color: color,
//               ),
//               alignment: Alignment.center,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => ProfileScreen()));
//                     },
//                     icon: const Icon(Icons.person),
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.search,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       showSearch(context: context, delegate: CustomSearchDelegate());
//                       // do something
//                     },
//                   )
//                 ],
//               ),
//             ))),
//         // appBar: AppBar(
//         //     leading: IconButton(
//         //       onPressed: () {
//         //          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileScreen() ));
//         //       },
//         //       icon: const Icon(Icons.person),
//         //     ),
//         //     actions: <Widget>[
//         //       IconButton(
//         //         icon: const Icon(
//         //           Icons.search,
//         //           color: Colors.white,
//         //         ),
//         //         onPressed: () {
//         //           // do something
//         //         },
//         //       )
//         //     ],
//         //     elevation: 5,
//         //     // ignore: deprecated_member_use
//         //     brightness: Brightness.light,
//         //     backgroundColor: color),
//         body: SafeArea(
//             child: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(color: color),
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       decoration: BoxDecoration(color: color),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(now.day.toString()),
//                                 const SizedBox(
//                                   height: 4,
//                                 ),
//                                 const Text("11/11/1111")
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.location_on_rounded,
//                                   color: Colors.white,
//                                   size: 25.0,
//                                 ),
//                                 Text("${city}")
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           left: 37, right: 37, top: 13, bottom: 34),
//                       child: Container(
//                         //padding: const EdgeInsets.only(left:35,right: 35 ),
//                         constraints: const BoxConstraints.expand(),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: backgroundImage, fit: BoxFit.cover),
//                         ),
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           children: <Widget>[
//                             Positioned(
//                               left: 108,
//                               right: 108,
//                               top: 30,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   debugPrint("Butona tıklandı");
//                                 },
//                                 child: Container(
//                                     width: 112,
//                                     height: 116,
//                                     decoration: BoxDecoration(
//                                       color: color,
//                                       borderRadius: const BorderRadius.all(
//                                         Radius.circular(10),
//                                       ),
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "${temperature}",
//                                               style: style2(),
//                                             ),
//                                             const Text(
//                                               "°",
//                                               style: TextStyle(fontSize: 50),
//                                             )
//                                           ],
//                                         ),
//                                         Text("Sunny", style: style3())
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                       flex: 5,
//                       child: Container(
//                         decoration: BoxDecoration(color: color),
//                       ))
//                 ],
//               ),
//             )
//           ],
//         )));
//   }


// }
//  class CustomSearchDelegate extends SearchDelegate{
// List<String> searchTerms=[
//   'aa',
//   'bb',
//   'cc',

// ];

//   @override
//   List<Widget>buildActions(BuildContext context){
//     return[
//       IconButton(onPressed: (){
//         query = '';
//       }, icon: Icon(Icons.clear))
//     ];
//   }
  
//   @override
//   Widget buildResults(BuildContext context){
//     List<String>matchQuery=[];
//     for(var fruit in searchTerms){
//       if(fruit.toLowerCase().contains(query.toLowerCase())){
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context,index){
//         var result=matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }

//   @override
//   Widget buildLeading(BuildContext context){
//     return(IconButton(onPressed: (){
//         close(context, null);
//       }, icon: Icon(Icons.arrow_back)));
      
    
//   }

//   @override
//   Widget buildSuggestions(BuildContext context){
//     List<String>matchQuery=[];
//     for(var fruit in searchTerms){
//       if(fruit.toLowerCase().contains(query.toLowerCase())){
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context,index){
//         var result=matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }
  

//  }


