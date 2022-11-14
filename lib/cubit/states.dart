abstract class WeatherStates {}

class WeatherInitialStates extends WeatherStates {}

class WeatherLoadinglStates extends WeatherStates {}

class WeatherSuccessStates extends WeatherStates {}

class WeatherErrorStates extends WeatherStates {
  dynamic error;
  WeatherErrorStates({this.error});
}

class WeatherForecastLoadinglStates extends WeatherStates {}

class WeatherForecastSuccessStates extends WeatherStates {}

class WeatherForecastErrorStates extends WeatherStates {
  dynamic error;
  WeatherForecastErrorStates({this.error});
}

class WeatherLoadingSearchState extends WeatherStates {}

class WeatherSuccessSearchState extends WeatherStates {}

class WeatherErrorSearchState extends WeatherStates {
  dynamic error;
  WeatherErrorSearchState({this.error});
}

class WeatherLoadingCitiesState extends WeatherStates {}

class WeatherSuccessCitiesState extends WeatherStates {}

class WeatherErrorCitiesState extends WeatherStates {
  dynamic error;
  WeatherErrorCitiesState({this.error});
}

class GetForecastWeatherSearchLoading extends WeatherStates {}

class GetForecastWeatherSearchSuccess extends WeatherStates {}

class GetForecastWeatherSearchError extends WeatherStates {
  dynamic error;
  GetForecastWeatherSearchError({this.error});
}
