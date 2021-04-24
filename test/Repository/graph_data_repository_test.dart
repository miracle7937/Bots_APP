


import 'package:bots_app/Actions/get_graph_data.dart';
import 'package:bots_app/Model/graph_model.dart';
import 'package:bots_app/Repository/graph_data_repo.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRepository extends Mock implements GraphDataRepo {}

void main() {
  GetGraphData  geGraphtData;
  MockRepository mockRepository;
  setUp(() {
    mockRepository = MockRepository();
    geGraphtData = GetGraphData(mockRepository);
  });



  final result = GraphModel(timestamps: "2018-04-30T00:00:00Z", prices: "8022.30126811",);
  final price = "8022.30126811";

  test("should get market model from the reposiory ", () async {
    when(mockRepository.getALLMarket()).thenAnswer((_) {
      return Stream.value([result]);
    });

    final data = geGraphtData .execute();

    data.forEach((v) {
      expect(price, v[0].prices);
    });
  });
}
