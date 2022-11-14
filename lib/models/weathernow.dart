class Weather {
  late Main main;
  late Wind wind;
  late Cloud cloud;
  late Coord coord;
  late String name;
  late Sys sys;

  Weather.fromjson(Map<String, dynamic> json) {
    name = json["name"];
    main = Main.fromjson(json["main"]);
    wind = Wind.fromjson(json["wind"]);
    cloud = Cloud.fromjson(json["clouds"]);
    coord = Coord.fromjson(json["coord"]);
    sys = Sys.fromjson(json["sys"]);
  }
}

class Coord {
  late double lat;
  late double lon;
  Coord.fromjson(Map<String, dynamic> json) {
    lat = json["lat"];
    lon = json["lon"];
  }
}

class Main {
  late double temperature;
  late int humidity;
  Main.fromjson(Map<String, dynamic> json) {
    temperature = json["temp"];
    humidity = json["humidity"];
  }
}

class Wind {
  late double speed;
  Wind.fromjson(Map<String, dynamic> json) {
    speed = json["speed"];
  }
}

class Cloud {
  late int all;
  Cloud.fromjson(Map<String, dynamic> json) {
    all = json["all"];
  }
}

class Sys {
  late String country;
  Sys.fromjson(Map<String, dynamic> json) {
    country = json["country"];
  }
}
