import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'tip_api_service.g.dart';

@RestApi(baseUrl: 'https://api.flutter-community.com/')
abstract class TipApiService {
  factory TipApiService(Dio dio, {String baseUrl}) = _TipApiService;

  @GET('/api/v1/advice')
  Future<void> getTip();
}
