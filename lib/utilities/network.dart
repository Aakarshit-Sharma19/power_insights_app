import 'package:dio/dio.dart';
import 'package:power_insights/constants.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
  ),
);
