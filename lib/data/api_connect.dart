import 'package:currency_conversion/models/currency_change_model.dart';
import 'package:currency_conversion/models/currency_model.dart';
import 'package:currency_conversion/utils/vars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiProvider {
  //Singleton
  ApiProvider._() {
    // Attach Logger
    if (kDebugMode) _dio.interceptors.add(_logger);
  }

  static final ApiProvider instance = ApiProvider._();

  // Http Client
  final Dio _dio = Dio();

  // Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    error: true,
  );

  // Headers
  final Map<String, dynamic> _apiHeaders = <String, dynamic>{
    'Accept': 'application/json',
  };

  ////////////////////////////// END POINTS ///////////////////////////////////
  static const String _getCurrenciesEndPoint = "symbols";
  static const String _getDataEndPoint = "timeseries";
  static const String _convertCurrencyEndPoint = "convert";
  ////////////////////////////// METHODS //////////////////////////////////////

  Future<List<CurrencyModel>> getCurrencies() async {
    final response = await _dio.get(
      '${Connection.apiURL}$_getCurrenciesEndPoint',
      options: Options(
        headers: _apiHeaders,
      ),
    );
    if (_validResponse(response.statusCode!)) {
      List<CurrencyModel> l = <CurrencyModel>[];
      final tmpMap = response.data["symbols"].entries.map((entry) {
        String code = entry.key;
        String description = entry.value['description'];
        return {'code': code, 'description': description};
      });
      for (var element in tmpMap) {
        l.add(CurrencyModel.fromMap(element));
      }
      return l;
    } else {
      throw response.data;
    }
  }

  Future<List<CurrencyChangeModel>> getCurrencyChanges(String startDate,
      String endDate, String currencyFrom, String currencyTo) async {
    final response = await _dio.get(
      '${Connection.apiURL}$_getDataEndPoint',
      queryParameters: {
        'start_date': startDate,
        'end_date': endDate,
        'base': currencyFrom,
        'symbols': currencyTo,
      },
      options: Options(
        headers: _apiHeaders,
      ),
    );
    if (_validResponse(response.statusCode!)) {
      List<CurrencyChangeModel> l = <CurrencyChangeModel>[];
      final tmpMap = response.data["rates"].entries.map((entry) {
        String date = entry.key;
        double value = entry.value[currencyTo];
        return {'date': date, 'value': value};
      });

      for (var element in tmpMap) {
        l.add(CurrencyChangeModel.fromMap(element));
      }
      return l;
    } else {
      throw response.data;
    }
  }

  Future<num> convertCurrency(
      String currencyFrom, String currencyTo, num amount) async {
    final response = await _dio.get(
      '${Connection.apiURL}$_convertCurrencyEndPoint',
      queryParameters: {
        'from': currencyFrom,
        'to': currencyTo,
        'amount': amount,
      },
      options: Options(
        headers: _apiHeaders,
      ),
    );
    if (_validResponse(response.statusCode!)) {
      return response.data["result"];
    } else {
      throw response.data;
    }
  }

  /////////////////////////////////////////////////////////////////////

  // Validating Request.
  bool _validResponse(int statusCode) => statusCode >= 200 && statusCode < 300;
}
