import 'package:dio/dio.dart';

extension DioErrorExtensions on DioError {
  bool get is401 => response?.statusCode == 401;

  bool get is406 => response?.statusCode == 406;

  bool get is40X =>
      (response?.statusCode ?? 0) >= 400 && (response?.statusCode ?? 0) < 500;

  bool get is500 => response?.statusCode == 500;

  String get readableError {
    // No Response ? then No Server...
    if (response?.data == null) {
      return "We couldn't reach our servers, please check your internet connection and try again.";
    }

    if (is500) {
      return "We have some issues please try again!";
    }

    // if response is String .. ex: 404
    if (response!.data.runtimeType == String) {
      // Url Not Found...
      if (response!.statusCode == 404) {
        return "Not found!";
      }
      return '${response!.data}';
      // Else if Server Returned something..
    } else if (response!.data is Map<String, dynamic>) {
      if (response!.data['errors'] != null &&
          response!.data['errors'] is Map<String, dynamic>) {
        return '${response!.data['errors'].values.first.first}';
      }
      if (response!.data.values.first is List) {
        return '${response!.data.values.first.first}';
      }
      return '${response!.data.values.first}';
    }

    return "System Error";
  }
}
