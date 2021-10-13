import 'package:dio/dio.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: 'http://10.0.2.2:8000/api',
  ),
);
