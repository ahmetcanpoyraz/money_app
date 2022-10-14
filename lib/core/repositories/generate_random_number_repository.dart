import 'dart:async';
import 'package:dio/dio.dart';
import '../constants/endpoints.dart';

class GenerateRandomNumberRepository {
  GenerateRandomNumberRepository._privateConstructor();
  static final GenerateRandomNumberRepository instance = GenerateRandomNumberRepository._privateConstructor();

  Future<Response> getGeneratedRandomNumber() async {
    var response = await Dio().get(
      "${Endpoints.base_url}/random?min=0&max=100&count=1",
    );
    return response;
  }

}