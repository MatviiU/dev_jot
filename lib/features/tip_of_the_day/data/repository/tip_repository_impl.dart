import 'package:dev_jot/features/tip_of_the_day/data/datasource/tip_api_service.dart';
import 'package:dev_jot/features/tip_of_the_day/domain/exceptions/tip_exception.dart';
import 'package:dev_jot/features/tip_of_the_day/domain/models/tip.dart';
import 'package:dev_jot/features/tip_of_the_day/domain/repositories/tip_repository.dart';
import 'package:dio/dio.dart';

class TipRepositoryImpl implements TipRepository {
  const TipRepositoryImpl({required TipApiService tipApiService})
    : _tipApiService = tipApiService;

  final TipApiService _tipApiService;

  @override
  Future<Tip> getTipOfTheDay() async {
    try {
      return await _tipApiService.getTip();
    } on DioException {
      throw FetchTipException();
    } catch (e) {
      throw UnknownTipException();
    }
  }
}
