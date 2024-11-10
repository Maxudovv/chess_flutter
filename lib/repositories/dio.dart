// ignore_for_file: avoid_print

// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';

import '../constants.dart';

Future<Dio> getDio([Map<String, dynamic>? headers]) async {
  final dio = Dio(BaseOptions(baseUrl: backendUrl, headers: headers));
  return dio;
}

