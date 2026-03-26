import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/config/network/dio_client.dart';
import '../../../core/config/network/dio_exceptions.dart';
import '../model/response/character_response_model.dart';

class DashboardRepository {
  Future<CharacterResponseModel> getCharacterList(String url) async {
    try {
      Response response = await DioClient().dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      return CharacterResponseModel.fromJson(response.data);
    } catch (e) {
      var errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = DioExceptions.fromDioError(e).toString();
      }
      debugPrint(errorMessage);

      return CharacterResponseModel();
    }
  }



}