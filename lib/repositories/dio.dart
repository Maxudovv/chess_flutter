// ignore_for_file: avoid_print

// Dart imports:
import 'dart:convert';
import 'package:dio/browser.dart';

// Package imports:
import 'package:dio/dio.dart';

import '../constants.dart';

Future<Dio> getDio([Map<String, dynamic>? headers]) async {
  headers = headers ?? {};
  headers["Content-type"] = "application/json";
  final dio = Dio(BaseOptions(baseUrl: backendUrl, headers: headers));
  return dio;
}

