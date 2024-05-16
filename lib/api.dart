import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

typedef PCName = String;
typedef ComparisonCode = String;

class API {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'http://100.93.220.13:5000';
  static final Dio _dio = Dio();
  static final String _smartphoneId = UniqueKey().toString();

  static PCName? _partnerPCName;
  static PCName? get partnerPCName => _partnerPCName;

  static Future<PCName?> pair(String pairingCode) async {
    try {
      var response = await _dio.post('$BASE_URL/setup/pair',
          data: {'smartphone-id': _smartphoneId, 'pairing_code': pairingCode});

      if (response.statusCode == 200) {
        var accepted = response.data['accepted'];
        if (accepted) {
          _partnerPCName = response.data['pc_name'];
          return partnerPCName;
        }
      }
    } on DioException {
      // ignore: avoid_catches_without_on_clauses
    }
    return null;
  }

  static Future<ComparisonCode?> pull() async {
    try {
      var response = await _dio.get('$BASE_URL/2fa/pull',
          options: Options(headers: {'Smartphone-Id': _smartphoneId}));
      if (response.statusCode == 200) {
        return response.data['comparison_code'];
      }
    } on DioException {
      // ignore: avoid_catches_without_on_clauses
    }
    return null;
  }

  static Future<bool> verify(String comparisonCode) async {
    try {
      var response = await _dio.post('$BASE_URL/2fa/verify', data: {
        'smartphone-id': _smartphoneId,
        'comparison_code': comparisonCode
      });

      if (response.statusCode == 200) {
        var verified = response.data['verified'];
        return verified;
      }
    } on DioException {
      // ignore: avoid_catches_without_on_clauses
    }
    return false;
  }
}
