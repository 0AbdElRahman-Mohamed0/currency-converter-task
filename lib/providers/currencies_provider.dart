import 'package:currency_conversion/data/api_connect.dart';
import 'package:currency_conversion/models/currency_model.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class CurrenciesProvider extends ChangeNotifier {
  final _api = ApiProvider.instance;

  List<CurrencyModel>? currencies;

  Future<void> getCurrencies() async {
    currencies = await _api.getCurrencies();
    notifyListeners();
  }
}
