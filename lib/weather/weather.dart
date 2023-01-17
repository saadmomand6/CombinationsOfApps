import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ==============================================SERVICES==========================//
// =========using api to get data
class Network{
  final String waetheruri;
  Network(this.waetheruri);
Future getweatherdata() async{
  http.Response response =await http.get(Uri.parse(waetheruri));
  if(response.statusCode==200){
    String weatherdata = response.body;
    var decodeweatherdata = jsonDecode(weatherdata);
    return decodeweatherdata;
  }else{
    // ignore: avoid_print
    print(response.statusCode);
  }

}
}
// ============
//=============using geolocator to get permission from phone and get currentlocation========
class Location{
  double? latitude;
  double? longitude;
  Future getcurrentlocationandpermission() async{
    try {
      LocationPermission permission = await Geolocator.requestPermission();
    // ignore: avoid_print
    print(permission);

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
     latitude =position.latitude;
    longitude =position.longitude;
    } catch (e) {
      // ignore: avoid_print
    print(e);
    }
  }
}
const apikey = "1e6c52c4b20afbd13f99df59be26fbab";
// =================
// ===========styling=====
const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
  color: Color.fromARGB(255, 228, 252, 14),
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
  color: Color.fromARGB(255, 228, 252, 14),
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: Color.fromARGB(255, 228, 252, 14),
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
// ====================
// 
class WeatherModel{
  Future getweatherofcurrentlocation() async{
    Location location = Location();
    await location.getcurrentlocationandpermission();
    Network networkhelper = Network('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherdetails = await networkhelper.getweatherdata(); 
    return weatherdetails;
  }
  Future getweatherforcity(String city) async{
      Network networkhelper = Network('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey&units=metric'); 
      var weatherdetails = await networkhelper.getweatherdata();
     return weatherdetails;
     
     }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
// ==============================================SERVICES END==========================//
// ============================loading page =====================//
class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
    getlocationandweatherdata();
  }
  void getlocationandweatherdata()async{
    var weatherdata = await WeatherModel().getweatherofcurrentlocation();
    if (!mounted) return;
     Navigator.push(context, MaterialPageRoute(builder: (context) {
      return  LocationScreen(locationweather: weatherdata,);
     }));
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:  Color(0xFF0A0E21),
      body: Center(
        child: SpinKitRipple(
          color:Color.fromARGB(255, 228, 252, 14),
          size: 50,
        ),
      ),
    );
  }
}
// ============================loading page  ends =====================//
// ============================location page =====================//
class LocationScreen extends StatefulWidget {
  final dynamic locationweather;
  const LocationScreen({super.key, this.locationweather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather= WeatherModel();

  late String weathericon;
  late int temperature;
  late String cityname;
  late String weathermessage;

  @override
  void initState() {
    super.initState();

    // ignore: avoid_print
    updateui(widget.locationweather);
  }
  void updateui(dynamic weatherdata){
    setState((){
      if (weatherdata == null){
        temperature=0;
        weathericon= 'error';
        weathermessage='there is an issue';
        cityname='app';
        return;
      }
      double temp = weatherdata['main'] ['temp'];
      temperature = temp.toInt();
      weathermessage = weather.getMessage(temperature);
      var condition= weatherdata['weather'] [0] ['id'];
      weathericon=weather.getWeatherIcon(condition);
      cityname = weatherdata['name'];
    });
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: const AssetImage('bgweather.jpg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.8), BlendMode.dstATop),
        //   ),
        // ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherbutton = await weather.getweatherofcurrentlocation();
                      updateui(weatherbutton);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 45,
                      color:  Color.fromARGB(255, 228, 252, 14),
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                     
                     var typedname= await Navigator.push(context, MaterialPageRoute(builder: (context)=> const CityScreen()));
                     if (typedname != null) {
                      var cityweatherdata =await weather.getweatherforcity(typedname);
                       updateui(cityweatherdata);
                     }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 45,
                      color: Color.fromARGB(255, 228, 252, 14),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children:  <Widget>[
                    Text(
                      '${temperature.toString()}°',
                      style: kTempTextStyle,
                    ),
                     Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const  EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weathermessage in $cityname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ============================location page ends=====================//
// ============================city page =====================//
class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SafeArea(child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: (){
                  Navigator.pop(context);
              }, child:const Icon(Icons.arrow_back_ios,size: 35,
                      color: Color.fromARGB(255, 228, 252, 14),)),
            ),
            Container(
              padding:const EdgeInsets.all(20),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 228, 252, 14),
                  icon:  Icon(Icons.location_city,
                      color: Color.fromARGB(255, 228, 252, 14),),
                      hintText: 'Enter the City Name',
                      hintStyle: TextStyle(color: Colors.black,),
              
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none),
                ),
                    onChanged: (value) {
                      cityname= value;
                    },
                    
    
                ),
                
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, cityname);
                  },
                  child: const Text(
                    'Get Weather',
                    style: kButtonTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Icon(Icons.location_on_sharp,
                color: Color.fromARGB(255, 228, 252, 14),
                size: 150,),
            
          ],
        )),
      ),
    );
  }
}


// ============================city page ends=====================//