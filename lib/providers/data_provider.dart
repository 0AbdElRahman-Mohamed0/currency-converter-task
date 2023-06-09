import 'package:currency_conversion/data/api_connect.dart';
import 'package:currency_conversion/models/currency_change_model.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class DataProvider extends ChangeNotifier {
  final _api = ApiProvider.instance;

  List<CurrencyChangeModel>? rates;
  num? convertResult;

  Future<void> getCurrencyChanges(String startDate, String endDate,
      String currencyFrom, String currencyTo) async {
    rates = await _api.getCurrencyChanges(
        startDate, endDate, currencyFrom, currencyTo);
    notifyListeners();
  }

  Future<void> convertCurrency(
      String currencyFrom, String currencyTo, num amount) async {
    convertResult =
        await _api.convertCurrency(currencyFrom, currencyTo, amount);
    notifyListeners();
  }
}
