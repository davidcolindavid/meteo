import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/meteo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MeteoApi {
  // get town
  static Future<Meteo> getMeteo(town) async {
    var token = dotenv.env['TOKEN'];

    final response = await http.Client().get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$town&appid=' + token!)
    );

    if (response.statusCode == 200) {
      return Meteo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load meteo');
    }

  }
}