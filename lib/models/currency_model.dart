class CurrencyModel {
  String? code;
  String? description;

  CurrencyModel.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  @override
  String toString() {
    return description ?? '';
  }
}
