import 'package:bots_app/Model/market_model.dart';
import 'package:bots_app/Repository/market_data_repository.dart';
import 'package:flutter/cupertino.dart';

class GetMarketData with ChangeNotifier {
  final MarketDataRepo repo;

  GetMarketData(this.repo);

 Stream<List<MarketModel>> execute() {
    return repo.getALLMarket();
  }
}
