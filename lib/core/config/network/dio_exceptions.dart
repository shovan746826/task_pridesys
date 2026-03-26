import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../global/util/global_function.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {

    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        systemMaintenance();
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        systemMaintenance();
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        systemMaintenance();
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        systemMaintenance();
        break;
      case DioExceptionType.connectionError:
        message = "connectionError";
        systemMaintenance();
        break;
      case DioExceptionType.badResponse:
        systemMaintenance();
        message = _handleError(dioError.response!.statusCode!, dioError.response!.data);
        break;
      default:
        message = _handleError(dioError.response!.statusCode!, dioError.response!.data);
        break;
    }
  }

  String message = '';

  String _handleError(int statusCode, dynamic errorData) {

    if (errorData is Map<String, dynamic>) {
      if (errorData.containsKey('message')) {
        return errorData['message'] as String;
      }
      return "Something went wrong";
    }else{
      switch (statusCode) {
        case 400:
          systemMaintenance();
          return "Bad Request";
        case 401:
          systemMaintenance();
          return "Session Expired Please";
        case 403:
          systemMaintenance();
          return "Session Expired Please";
        case 404:
          systemMaintenance();
          return "Service Not Found";
        case 500:
          systemMaintenance();
          return 'Internal server error';
        case 502:
          systemMaintenance();
          return 'An invalid response was received from the upstream server';
        default:
          return 'Something went wrong';
      }
    }
  }

  @override
  String toString() => message;

  systemMaintenance() async{

  }

}


