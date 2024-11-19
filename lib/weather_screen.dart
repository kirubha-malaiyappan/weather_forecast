import 'dart:ui';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:weather_app/Hourly_Forecast.dart';
import 'package:weather_app/additional_info.dart';
import 'package:intl/intl.dart';



class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp=0;
 
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }
  
  Future<Map<String,dynamic>> getCurrentWeather() async{
    try{
    
     final res = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=India,Chennai&APPID=b399c6038b6547a8eceb952067bd9443",)
    );
     final data = jsonDecode(res.body);
     if(data['cod'] != '200'){
      throw "An unexpected error occured";
     }
     
      return data; 
       
          //temp = data['list'][0]['main']['temp'];
          
    
     
    }
  
    catch(e){
      throw e.toString();
    }
    
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Weather App", style: TextStyle(
          fontWeight: FontWeight.bold,
          
        ),

        ),
        centerTitle: true,
        actions:   [ 
          IconButton(onPressed: (){
                print("Hello");
          }, icon: const Icon(Icons.refresh)
          )
          
         ],

      ),
      body : FutureBuilder(
        future: getCurrentWeather(), 
        builder: (context, snapshot) {
         if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator.adaptive());
         }
         if (snapshot.hasError){
          return Text(snapshot.error.toString());
         }

         final data = snapshot.data!;
         final current = data['list'][0];
         final currentTemp = current['main']['temp'];
         final currentWeather = current['weather'][0]['main'];
         final pressure = current['main']['pressure']; 
         final windSpeed = current['wind']['speed'];  
         final humidity = current['main']['humidity'];      
         return Padding(
         padding: const EdgeInsets.all(16.0),
         child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: SizedBox(
                  width: double.infinity,
                 child: Card(
                 elevation: 10.0,
                 shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                 ),
                  child:  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:  Column(
                      children: [
                         Text("$currentTemp", style:const TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 5),
                         data['list'][0]['weather'][0]['main']=="Clouds" || data['list'][0]['weather'][0]['main']== "Rainy" ?
                         const Icon(Icons.cloud, size: 64.0, ) : 
                        const  Icon(Icons.sunny, size: 64.0, ) ,
                        const SizedBox(height: 5),
                        Text("$currentWeather", style: const TextStyle(
                          fontSize: 20.0
                        ),
                        ),
                      ],
                    ),
                  ) ,
                 ),
                ),
            ),
            
            const SizedBox(height: 30.0,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Weather Forecast ", style: TextStyle(
                fontWeight:  FontWeight.bold,
                fontSize: 24,
              ),
              ),
            ),
            const SizedBox(height: 20
            ),
            //small cards
          //  SingleChildScrollView(
          //    scrollDirection: Axis.horizontal,
          //     child:  Row(
          //      children: [
          //       for(int i=1;i<8;i++)
          //        //First small card
          //        HourlyForecast( time:" ${data['list'][i]['dt'].toString()}",
          //         icon:data['list'][0]['weather'][0]['main']=="Clouds" || data['list'][0]['weather'][0]['main']== "Rainy" ?
          //                Icons.cloud  : Icons.sunny  ,
          //          temp :  "${data['list'][i]['main']['temp']}"
          //          )
                
          //      ],
          //     ),
          //   ),
              SizedBox(
                height: 120.0,

                child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal ,
                  itemBuilder: (context, index) {
                    final timestamp = data['list'][index+1]['dt'] * 1000; // Multiply by 1000 to convert seconds to milliseconds
                    final time = DateTime.fromMillisecondsSinceEpoch(timestamp);
                    final hourlyForecast = data['list'][index+1];
                    final hourlyTemp = hourlyForecast['main']['temp'];
                    final hourlySky = hourlyForecast['weather'][0]['main'];
                  
                    return HourlyForecast( time: DateFormat.Hm().format(time),
                   icon:hourlySky=="Clouds" || hourlySky== "Rainy" ?
                          Icons.cloud  : Icons.sunny  ,
                    temp :  "$hourlyTemp"
                   );

                },),
              ),
              const SizedBox(height: 30.0,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Additional Information ", style: TextStyle(
                fontWeight:  FontWeight.bold,
                fontSize: 24,
              ),
              ),
            ),
            const SizedBox(height: 10
            ),
             //additional things
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 //humidity
                   WeatherAppAdditionalThings(icon : Icons.water_drop, label: "Humidity", value : humidity.toString()),
                   WeatherAppAdditionalThings(icon : Icons.air, label: "wind Speed", value : windSpeed.toString()),
                  WeatherAppAdditionalThings(icon : Icons.beach_access, label: "Pressure", value : "$pressure"),
                 //windspeed
                 
               ],
              ),
          ],
         ),
               );
        }
      )
    );
}
}


