import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:power_insights/utilities/network.dart';
import 'package:power_insights/utilities/store.dart';

Future<void> addInterceptor() async {
  final String token = await persistentStorage.read(key: 'token') ?? '';
  if (token == '') return;
  dio.interceptors.add(
    InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Authorization'] = 'Token $token';
      handler.next(options);
    }),
  );
}

Future<bool> login(String email, String password, BuildContext context) async {
  Response response;
  try {
    response = await dio.post('/accounts/api-auth-token/',
        data: {'username': email, 'password': password});
  } on DioError catch (e) {}
  if (response?.statusCode == 200) {
    var body = response.data;
    persistentStorage.write(key: 'token', value: body['token']);
    final snackBar = SnackBar(content: Text('Login Successful'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    addInterceptor();
    return true;
  } else if (response?.statusCode == 400) {
    final snackBar =
        SnackBar(content: Text('Wrong Email or Password! Check and Try Again'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    final snackBar =
        SnackBar(content: Text('Internal Error while logging in.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  return false;
}

Future<bool> verifyToken(BuildContext context) async {
  final String token = await persistentStorage.read(key: 'token') ?? '';
  if (token == '') return false;
  Response response;
  try {
    response = await dio.get('/verify_token/',
        options: Options(headers: {'Authorization': 'Token $token'}));
    if (response.statusCode == 204) {
      addInterceptor();
      return true;
    }
    return true;
  } on DioError catch (e) {
    if (e.response?.statusCode ?? -1 != 401) {
      throw e;
    }
  }
  return false;
}

Future<void> logout() async {
  final String token = await persistentStorage.read(key: 'token') ?? '';
  if (token == '') return;

  try {
    await dio.get('/accounts/logout/',
        options: Options(headers: {'Authorization': 'Token $token'}));
    persistentStorage.delete(key: 'token');
  } on DioError catch (e) {
    return;
  }
}
