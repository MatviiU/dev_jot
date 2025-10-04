import 'package:dev_jot/features/tip_of_the_day/domain/models/tip.dart';

abstract interface class TipRepository {
  Future<Tip> getTipOfTheDay();
}
