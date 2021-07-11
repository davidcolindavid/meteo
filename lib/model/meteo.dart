class Meteo {
  String name;
  Main main;

  Meteo({
    required this.name,
    required this.main,
  });

  factory Meteo.fromJson(Map<String, dynamic> json) {
    return Meteo(
      name: json['name'],
      main: Main.fromJson(json['main']),
    );
  }
}

class Main {
  final dynamic temp;
  final dynamic feelsLike;
  final dynamic tempMin;
  final dynamic tempMax;
  final dynamic pressure;
  final dynamic humidity;

  const Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}
