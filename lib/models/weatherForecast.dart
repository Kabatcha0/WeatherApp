class WeatherForecast {
  late String cod;
  List<ListOfWeatherForecast> listOfWeatherForecast = [];
  WeatherForecast.fromJson(Map<String, dynamic> json) {
    cod = json["cod"];
    json["list"].forEach((element) {
      listOfWeatherForecast.add(ListOfWeatherForecast.fromJson(element));
    });
  }
}

class ListOfWeatherForecast {
  late String dt;
  late double temp;
  late int hum;
  ListOfWeatherForecast(
      {required this.dt, required this.temp, required this.hum});
  ListOfWeatherForecast.fromJson(Map<String, dynamic> json) {
    dt = json["dt_txt"];
    temp = json["main"]["temp"];
    hum = json["main"]["humidity"];
  }
}
