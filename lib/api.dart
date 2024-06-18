import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:veracrypt_2fa_app/snackbar.dart';

typedef PCName = String;
typedef ComparisonCode = String;

class API {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'http://152.53.3.7:6000';
  static final Dio _dio = Dio();
  static final String _smartphoneId = UniqueKey().toString();

  static PCName? _partnerPCName;
  static PCName? get partnerPCName => _partnerPCName;

  static Future<PCName?> pair(BuildContext context, String pairingCode) async {
    try {
      var response = await _dio.post('$BASE_URL/setup/pair',
          options: Options(
              headers: {
                'Smartphone-Id': _smartphoneId,
                'Pairing-Code': pairingCode,
              },
              sendTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5)));

      if (response.statusCode == 200) {
        var accepted = response.headers.value('Accepted');
        if (accepted == 'True') {
          _partnerPCName = response.headers.value('Pc-Name');
          return partnerPCName;
        }
      }
    } on DioException catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        Snackbar.show(context, "Keine Verbindung zum Server");
      }
    }
    return null;
  }

  static Future<ComparisonCode?> pull(BuildContext context) async {
    if (_partnerPCName == null) {
      Snackbar.show(context, "Nicht mit einem Computer verbunden.");
      return null;
    }

    try {
      var response = await _dio.get('$BASE_URL/2fa/pull',
          options: Options(
            headers: {'Smartphone-Id': _smartphoneId},
            sendTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
          ));
      if (response.statusCode == 200) {
        return response.headers.value('Comparison-Code');
      } else {
        Snackbar.show(context, "Keine ausstehenden Anfragen.");
      }
    } on DioException catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        Snackbar.show(context, "Keine Verbindung zum Server");
      }
    }
    return null;
  }

  static Future<bool> verify(
      BuildContext context, String comparisonCode) async {
    try {
      var response = await _dio.post('$BASE_URL/2fa/verify',
          options: Options(
              headers: {
                'Smartphone-Id': _smartphoneId,
                'Comparison-Code': comparisonCode,
              },
              sendTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5)));

      if (response.statusCode == 200) {
        var verified = response.headers.value('Verified');
        return verified == 'True';
      }
    } on DioException catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        Snackbar.show(context, "Keine Verbindung zum Server");
      }
    }
    return false;
  }

  static Future<bool> awaitVerification(
      BuildContext context, String pcId) async {
    try {
      var response = await _dio.post('$BASE_URL/2fa/await',
          options: Options(
              headers: {'Pc-Id': pcId},
              sendTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5)));

      if (response.statusCode == 200) {
        var verified = response.headers.value('Verified');
        return verified == 'True';
      }
    } on DioException catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        Snackbar.show(context, "Keine Verbindung zum Server");
      }
    }
    return false;
  }

  static void unpair(BuildContext context) {
    Snackbar.show(context, "Verbindung mit dem PC lokal getrennt.");
    _partnerPCName = null;
  }
}
