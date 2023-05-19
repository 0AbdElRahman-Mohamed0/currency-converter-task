class CurrencyChangeModel {
  String? date;
  num? value;

  CurrencyChangeModel.fromMap(Map<String, dynamic> json) {
    date = json['date'];
    value = json['value'];
  }
}
