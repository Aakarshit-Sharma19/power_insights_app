import 'package:dio/dio.dart';
import 'package:power_insights/models/power_consumption.dart';
import 'package:power_insights/utilities/network.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Future<List<Map<String, dynamic>>> getDailyData(int month, int year) async {
Future<List> getDailyData(int month, int year) async {
  try {
    var response = await dio
        .get('/consumption/', queryParameters: {'month': month, 'year': year});
    var data = (response.data as List).map((e) {
      return PowerConsumption.fromJson(e);
    }).toList();
    return data;
  } on DioError catch (e) {
    print(e.response.statusCode);
    return [];
  }
}

Future<List<MonthlyPowerConsumption>> getMonthlyData(int year) async {
  try {
    var response =
        await dio.get('/consumption/', queryParameters: {'year': year});
    var data = (response.data as List).map((e) {
      return MonthlyPowerConsumption.fromJson(e, year);
    }).toList();
    return data;
  } on DioError catch (e) {
    print(e.response.statusCode);
    return [];
  }
}

List<charts.Series<MonthlyPowerConsumption, DateTime>> parseMonthlyData(
    List<MonthlyPowerConsumption> data) {
  print(data);
  return [
    new charts.Series<MonthlyPowerConsumption, DateTime>(
      id: 'power_consumption',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (MonthlyPowerConsumption consumption, _) => consumption.date,
      measureFn: (MonthlyPowerConsumption consumption, _) =>
          consumption.consumption,
      data: data,
    )
  ];
}

List<charts.Series<PowerConsumption, DateTime>> parseDailyData(
    List<PowerConsumption> data) {
  print(data);
  return [
    new charts.Series<PowerConsumption, DateTime>(
      id: 'power_consumption',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (PowerConsumption consumption, _) => consumption.date,
      measureFn: (PowerConsumption consumption, _) => consumption.consumption,
      data: data,
    )
  ];
}
