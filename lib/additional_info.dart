
import 'package:flutter/material.dart';

class WeatherAppAdditionalThings extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const WeatherAppAdditionalThings({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:  const EdgeInsets.all(18),
      child:  Column(
              children: [
                Icon(icon, size: 40,),
               const  SizedBox(height: 10,),
                Text(label, style: const TextStyle(fontSize: 15,),),
                const SizedBox(height: 10,),
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
              ],
      ),
    );
  }
}