import 'package:bots_app/Model/market_model.dart';
import 'package:bots_app/utils/end_point.dart';
import 'package:bots_app/utils/request.dart';

abstract class MarketDataRepo {
  Stream<List<MarketModel>> getALLMarket();
}

class MarketDataRepoImplementaion extends MarketDataRepo {
  final HttpRequest httpRequest;

  MarketDataRepoImplementaion({this.httpRequest});

  @override
  Stream<List<MarketModel>> getALLMarket() {
    // _marketData;
    var data = httpRequest.getCall(allExchange, handleError: true).then((v) {
      List<MarketModel> _marketData =
          v.map<MarketModel>((v) => MarketModel.json(v)).toList();
      return _marketData;
    });

    return Stream.fromFuture(data);
  }

 
}
