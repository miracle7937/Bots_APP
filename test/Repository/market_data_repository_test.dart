import 'package:bots_app/Actions/getMarketData.dart';
import 'package:bots_app/Model/market_model.dart';
import 'package:bots_app/Repository/market_data_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRepository extends Mock implements MarketDataRepo {}

void main() {
  GetMarketData getMarketData;
  MockRepository mockRepository;
  setUp(() {
    mockRepository = MockRepository();
    getMarketData = GetMarketData(mockRepository);
  });



  final result = MarketModel(name: "Bitcoin", price: "41691.15492434");
  final price = "41691.15492434";

  test("should get market model from the reposiory ", () async {
    when(mockRepository.getALLMarket()).thenAnswer((_) {
      return Stream.value([result]);
    });

    final data = getMarketData.execute();

    data.forEach((v) {
      expect(price, v[0].price);
    });
  });
}
