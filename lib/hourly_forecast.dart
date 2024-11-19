



import 'package:flutter/material.dart' show BorderRadius, BoxDecoration, BuildContext, Card, Column, Container, EdgeInsets, FontWeight, Icon, IconData, Icons, Padding, SizedBox, StatelessWidget, Text, TextOverflow, TextStyle, Widget;
import 'package:flutter/src/widgets/framework.dart';



class HourlyForecast extends StatefulWidget {
  final String time;
  final IconData icon;
  final String temp;
  const HourlyForecast({super.key,
  required this.time,
  required this.icon, 
  required this.temp});

  @override
  State<HourlyForecast> createState() => _HourlyForecastState();
}

class _HourlyForecastState extends State<HourlyForecast> {
 

  @override
  Widget build(BuildContext context) {
    return  Container(
             width: 100,
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
             ),
      child: Card(
                        child: Padding(
                          padding:const  EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(widget.time , 
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                              style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ,),
                              const SizedBox(height: 5.0,),
                              Icon(widget.icon, size: 22,),
                               const SizedBox(height: 8.0,),
                              Text(widget.temp, style: const TextStyle(
                                fontSize: 15,
                              ),)
                            ],
                          ),
                        ),
                      ),
    );
  }
}