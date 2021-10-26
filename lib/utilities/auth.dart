import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:power_insights/utilities/network.dart';
import 'package:power_insights/utilities/store.dart';
import 'package:power_insights/routes.dart';

class DioConfiguration {
  InterceptorsWrapper authInterceptor;
}

DioConfiguration _dioConfiguration = DioConfiguration();

Future<void> addAuthInterceptor() async {
  final String token = await persistentStorage.read(key: 'token') ?? '';
  _dioConfiguration.authInterceptor =
      InterceptorsWrapper(onRequest: (options, handler) {
    options.headers['Authorization'] = 'Token $token';
    handler.next(options);
  });
  if (token == '') return;
  dio.interceptors.add(_dioConfiguration.authInterceptor);
}

Future<bool> login(String email, String password, BuildContext context) async {
  Response response;
  try {
    response = await dio.post('/accounts/api-auth-token/',
        data: {'username': email, 'password': password});
  } on DioError catch (e) {
    if (e.response?.statusCode == 400) {
      final snackBar = SnackBar(
          content: Text('Wrong Email or Password! Check and Try Again'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }
  if (response?.statusCode == 200) {
    var body = response.data;
    persistentStorage.write(key: 'token', value: body['token']);
    final snackBar = SnackBar(content: Text('Login Successful'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    addAuthInterceptor();
    return true;
  } else {
    final snackBar =
        SnackBar(content: Text('Internal Error while logging in.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  return false;
}

Future<bool> logout(BuildContext context) async {
  Response response;
  try {
    response = await dio.post('/accounts/logout/');
  } on DioError catch (e) {
    print(e);
    print(e.response.data);
    Navigator.of(context).pushReplacementNamed(Routes.login);
    return false;
  }
  if (response.statusCode == 200) {
    dio.interceptors.remove(_dioConfiguration.authInterceptor);
    persistentStorage.delete(key: 'token');
    Navigator.of(context).pushReplacementNamed(Routes.login);
    return true;
  }
  return false;
}

Future<bool> verifyToken() async {
  final String token = await persistentStorage.read(key: 'token') ?? '';
  if (token == '') return false;
  Response response;
  try {
    response = await dio.get('/verify_token/',
        options: Options(
            headers: {'Authorization': 'Token $token'},
            validateStatus: (statusCode) => statusCode < 500));
    if (response.statusCode == 204) {
      addAuthInterceptor();
      return true;
    }
  } on DioError catch (e) {
    if (e.response?.statusCode ?? -1 != 401) {
      throw e;
    }
  } catch (e) {
    persistentStorage.deleteAll();
    return false;
  }
  return false;
}
