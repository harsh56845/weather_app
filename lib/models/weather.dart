class Weather {
  double temp;
  String city;
  double humidity;
  double windSpeed;
  Weather(
      {required this.city,
      required this.temp,
      required this.humidity,
      required this.windSpeed});

  // var data = jsonDecode(response.body);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temp: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}
