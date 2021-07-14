import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/meteo.dart';


class MeteoApi {
  // get town
  static Future<Meteo> getMeteo(town) async {
    final response = await http.Client().get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$town&appid=499f83b1699676a4fd1afa6569c3cfb9')
    );

    if (response.statusCode == 200) {
      return Meteo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load meteo');
    }

  }
}