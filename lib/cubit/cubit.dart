import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubit/states.dart';
import 'package:weatherapp/models/weatherForecast.dart';
import 'package:weatherapp/models/weathernow.dart';
import 'package:weatherapp/shared/remote/dioHelper.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitialStates());
  static WeatherCubit get(context) => BlocProvider.of(context);
  Weather? currentWeather;
  void getCurrentWeather({required String city}) {
    emit(WeatherLoadinglStates());
    DioHelper.getData(
            path: "data/2.5/weather",
            query: {"q": city, "appid": "448ec6576effbfbb2525fe0e43b758f1"})
        .then((value) {
      currentWeather = Weather.fromjson(value.data);
      emit(WeatherSuccessStates());
    }).catchError((onError) {
      emit(WeatherErrorStates(error: onError));
    });
  }

  List<Weather> getCities = [];
  final List<String> cities = [
    "cairo",
    "london",
    "paris",
    "roma",
    "madrid",
    "moscow",
    "new york",
    "barcelona"
  ];
  void getCurrentWeatherCities() {
    getCities = [];
    for (int i = 0; i <= cities.length - 1; i++) {
      emit(WeatherLoadingCitiesState());
      DioHelper.getData(path: "data/2.5/weather", query: {
        "q": cities[i],
        "appid": "448ec6576effbfbb2525fe0e43b758f1"
      }).then((value) {
        getCities.add(Weather.fromjson(value.data));
        emit(WeatherSuccessCitiesState());
      }).catchError((onError) {
        emit(WeatherErrorCitiesState(error: onError));
      });
    }
  }

  Weather? search;

  void getSearch({required String city}) {
    emit(WeatherLoadingSearchState());
    DioHelper.getData(
            path: "data/2.5/weather",
            query: {"q": city, "appid": "448ec6576effbfbb2525fe0e43b758f1"})
        .then((value) {
      search = Weather.fromjson(value.data);
      emit(WeatherSuccessSearchState());
      // search = null;
    }).catchError((onError) {
      emit(WeatherErrorSearchState(error: onError));
    });
  }

  late WeatherForecast weatherForecast;
  List<ListOfWeatherForecast> listOfcity = [];
  void getForecastWeather({required String city}) {
    emit(WeatherForecastLoadinglStates());
    listOfcity = [];
    DioHelper.getData(
            path: "data/2.5/forecast",
            query: {"q": city, "appid": "448ec6576effbfbb2525fe0e43b758f1"})
        .then((value) {
      weatherForecast = WeatherForecast.fromJson(value.data);
      weatherForecast.listOfWeatherForecast.forEach((element) {
        // print(element.dt);
        listOfcity.add(element);
      });
      print(listOfcity[0].temp);
      print(listOfcity[0].dt);
      print(listOfcity[0].hum);

      emit(WeatherForecastSuccessStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(WeatherForecastErrorStates(error: onError));
    });
  }

  late WeatherForecast weatherForecastSearch;
  List<ListOfWeatherForecast> listOfCitySearch = [];
  void getForecastWeatherSearch({required String city}) {
    emit(GetForecastWeatherSearchLoading());
    listOfCitySearch = [];
    DioHelper.getData(
            path: "data/2.5/forecast",
            query: {"q": city, "appid": "448ec6576effbfbb2525fe0e43b758f1"})
        .then((value) {
      weatherForecastSearch = WeatherForecast.fromJson(value.data);
      weatherForecastSearch.listOfWeatherForecast.forEach((element) {
        // print(element.dt);
        listOfCitySearch.add(element);
      });
      // print(listOfcity[0].temp);
      // print(listOfcity[0].dt);
      // print(listOfcity[0].hum);

      emit(GetForecastWeatherSearchSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetForecastWeatherSearchError(error: onError));
    });
  }
}
