import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weatherapp/cubit/cubit.dart';
import 'package:weatherapp/cubit/states.dart';
import 'package:weatherapp/models/weatherForecast.dart';
import 'package:weatherapp/models/weathernow.dart';

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()
        ..getCurrentWeather(city: "cairo")
        ..getForecastWeather(city: "cairo")
        ..getCurrentWeatherCities(),
      child: BlocConsumer<WeatherCubit, WeatherStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = WeatherCubit.get(context);
          TextEditingController search = TextEditingController();
          return Scaffold(
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConditionalBuilder(
                condition: cubit.currentWeather != null &&
                    cubit.listOfcity.isNotEmpty &&
                    cubit.getCities.isNotEmpty,
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
                builder: (context) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is WeatherLoadingSearchState ||
                          state is GetForecastWeatherSearchLoading)
                        const LinearProgressIndicator(),
                      if (state is WeatherLoadingSearchState ||
                          state is GetForecastWeatherSearchLoading)
                        const SizedBox(
                          height: 5,
                        ),
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: Stack(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25))),
                              width: double.infinity,
                              height: 200,
                              child: const Image(
                                image: AssetImage(
                                  "assets/images/cloud-in-blue-sky.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                controller: search,
                                onFieldSubmitted: (city) {
                                  cubit.getSearch(city: city);
                                  cubit.getForecastWeatherSearch(city: city);
                                  search.text = "";
                                },
                                decoration: InputDecoration(
                                  iconColor: Colors.white,
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 3)),
                                  hintText: "Search",
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    elevation: 8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          cubit.search != null
                                              ? cubit.search!.name
                                              : "Cairo",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.grey[700]),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                cubit.search != null
                                                    ? "${(cubit.search!.main.temperature - 273.15).round()}\u00B0C"
                                                    : "${(cubit.currentWeather!.main.temperature - 273.15).round()}\u00B0C",
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.grey[700]),
                                              ),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                              Container(
                                                width: 100,
                                                height: 100,
                                                child: const Image(
                                                  image: AssetImage(
                                                      "assets/images/icon-01.jpg"),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "other Cities",
                        style: TextStyle(color: Colors.grey[600], fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                card(cubit.getCities[index]),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 10,
                                ),
                            itemCount: cubit.getCities.length),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                              text: 'ForeCast Next FiveDays',
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              ),
                              alignment: ChartAlignment.near),
                          // Enable legend
                          // legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<ListOfWeatherForecast, String>>[
                            SplineSeries<ListOfWeatherForecast, String>(
                                dataSource: cubit.listOfCitySearch.isEmpty
                                    ? cubit.listOfcity
                                    : cubit.listOfCitySearch,
                                xValueMapper:
                                    (ListOfWeatherForecast sales, _) =>
                                        sales.dt,
                                yValueMapper:
                                    (ListOfWeatherForecast sales, _) =>
                                        (sales.temp - 273.15).round(),
                                name: 'temp',
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: false))
                          ])
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }

  Widget card(Weather model) => Container(
        height: 200,
        width: 170,
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                model.name,
                style: TextStyle(fontSize: 30, color: Colors.grey[700]),
              ),
              Text(
                "${((model.main.temperature) - 273.15).round()}\u00B0C",
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 50,
                height: 50,
                child: const Image(
                  image: AssetImage("assets/images/icon-01.jpg"),
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      );
}
