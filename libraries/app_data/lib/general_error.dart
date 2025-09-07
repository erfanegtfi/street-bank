import 'package:app_data/remote/exception/app_exception.dart';
import 'package:app_data/remote/exception/connection_timeout_exception.dart';
import 'package:app_data/remote/exception/network_connection_exception.dart';
import 'package:app_data/remote/exception/unknown_exception.dart';
import 'package:design_system/app_text.dart';
import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

class GeneralError {
  int? _errorCode;
  String _message = "";
  AppException? _appException;

  int? get errorCode => _errorCode;
  AppException? get appException => _appException;

  set message(String value) {
    _message = value;
  }

  String get message {
    if (_message.isNotEmpty) {
      return _message;
    } else {
      _message = _getMessageFromAppException(_appException) ?? AppText.errorUnknown;

      return _message;
    }
  }

  GeneralError._();

  GeneralError.withDioError(DioException? error) {
    if (error != null) {
      _appException = _setErrorType(error);
    }
    if (!kReleaseMode) {
      debugPrint(error.toString());
    }
  }

  GeneralError.withAppException(AppException? appException) {
    if (appException != null) _appException = appException;
    if (!kReleaseMode) {
      debugPrint(appException?.getMessage());
    }
  }

  GeneralError.withMessage(String? message) {
    if (message?.isNotEmpty == true) _message = message!;
    if (!kReleaseMode) {
      debugPrint(message);
    }
  }

  ///get dio error type
  AppException? _setErrorType(DioException? error) {
    AppException? appException;
    _errorCode = error?.response?.statusCode;

    switch (error?.type) {
      case DioExceptionType.cancel:
        appException = UnknownException();
        break;
      case DioExceptionType.unknown:
        appException = UnknownException();
        break;
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        appException = ConnectionTimeoutException();
        break;
      case DioExceptionType.connectionError:
        appException = NetworkConnectionException();
        break;
      case DioExceptionType.badResponse:
        break;
      default:
        break;
    }

    return appException;
  }

  ///get error message based on server error
  String? _getMessageFromAppException(AppException? error) {
    return error?.getMessage();
  }
}
