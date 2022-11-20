//ignore_for_file: unused_import
import 'package:flutter_application_1/api/weather_api.dart';
import 'package:flutter_application_1/pages/main_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:flutter_application_1/utils/location.dart';
import 'package:intl/intl.dart';

class LoadingScreen extends StatefulWidget {

 
  
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  
  late LocationHelper locationData;

  //Konum bilgisi sorgulanır

  Future<void>getLocationData()async{
    locationData=LocationHelper();
    await locationData.getCurrentLocation();

    if(locationData.latitude == null || locationData.longitude==null){
      print("Konum bilgileri gelmiyor");
    }else{
      print("latitude  " + locationData.latitude.toString());
      print("longitude  " + locationData.longitude.toString());

    }
  }

  //Sıcaklık ve durum bilgisi kontrol edilir, veri geldiği taktirde görüntülenecek ekran çalışır.
  void getWeatherData() async{
    await getLocationData();
   
    
    WeatherData weatherData=WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    

    if(weatherData.currentTemperature ==null ||
    weatherData.main==null){
      print("API den sıcaklık veya durum bilgisi boş dönüyor");
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> 
    MainScreen( 
      weatherData: weatherData, 
    
      
    ) ));   

  }
  //getWeatherData fonksiyonunda anlık değişimler kontrol edilir

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  //Sorgulama yapılırken görüntülenen ekran
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.blue]
          ),
        ),
        child: const Center(
          child:  SpinKitFadingCircle(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
