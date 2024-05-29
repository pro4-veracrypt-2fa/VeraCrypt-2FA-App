import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:veracrypt_2fa_app/snackbar.dart';

typedef PCName = String;
typedef ComparisonCode = String;

class API {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'http://100.89.24.72:6000';
  static final Dio _dio = Dio();
  static final String _smartphoneId = UniqueKey().toString();

  static PCName? _partnerPCName;
  static PCName? get partnerPCName => _partnerPCName;

  static Future<PCName?> pair(BuildContext context, String pairingCode) async {
    try {
      var response = await _dio.post('$BASE_URL/setup/pair',
          data: {'smartphone-id': _smartphoneId, 'pairing_code': pairingCode},
          options: Options(
              sendTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5)));

      if (response.statusCode == 200) {
        var accepted = response.data['accepted'];
        if (accepted) {
          _partnerPCName = response.data['pc_name'];
          return partnerPCName;
        }
      }
    } on DioException catch (e) {
      // ignore: deprecated_member_use
      if (e.type == DioErrorType.connectionTimeout ||
          // ignore: deprecated_member_use
          e.type == DioErrorType.sendTimeout ||
          // ignore: deprecated_member_use
          e.type == DioErrorType.receiveTimeout) {
        // ignore: use_build_context_synchronously
        Snackbar.show(context, "Keine Verbindung zum Server");
      }
    }
    return null;
  }

  static Future<ComparisonCode?> pull(BuildContext context) async {
    try {
      var response = await _dio.get('$BASE_URL/2fa/pull',
          options: Options(
            headers: {'Smartphone-Id': _smartphoneId},
            sendTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
          ));

      if (response.statusCode == 200) {
        return response.data['comparison_code'];
      }
    } on DioException catch (e) {
      // ignore: deprecated_member_use
      if (e.type == DioErrorType.connectionTimeout ||
          // ignore: deprecated_member_use
          e.type == DioErrorType.sendTimeout ||
          // ignore: deprecated_member_use
          e.type == DioErrorType.receiveTimeout) {
        // ignore: use_build_context_synchronously
        Snackbar.show(context, "Keine Verbindung zum Server");
      }
    }
    return null;
  }

  static Future<bool> verify(
      BuildContext context, String comparisonCode) async {
    try {
      var response = await _dio.post('$BASE_URL/2fa/verify',
          data: {
            'smartphone-id': _smartphoneId,
            'comparison_code': comparisonCode
          },
          options: Options(
              sendTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5)));

      if (response.statusCode == 200) {
        var verified = response.data['verified'];
        return verified;
      }
    } on DioException catch (e) {
      // ignore: deprecated_member_use
      if (e.type == DioErrorType.connectionTimeout ||
          // ignore: deprecated_member_use
          e.type == DioErrorType.sendTimeout ||
          // ignore: deprecated_member_use
          e.type == DioErrorType.receiveTimeout) {
        // ignore: use_build_context_synchronously
        Snackbar.show(context, "Keine Verbindung zum Server");
      }
    }
    return false;
  }
}
