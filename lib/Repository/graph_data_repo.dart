import 'package:bots_app/Model/graph_model.dart';
import 'package:bots_app/utils/end_point.dart';
import 'package:bots_app/utils/list_conbination_function.dart';
import 'package:bots_app/utils/request.dart';

abstract class GraphDataRepo {
  Stream<List<GraphModel>> getALLMarket();
}

class GraphDataRepoImplementaion extends GraphDataRepo {
  final HttpRequest httpRequest;

  GraphDataRepoImplementaion({this.httpRequest});

  @override
  Stream<List<GraphModel>> getALLMarket() {
    // _marketData;
    var data = httpRequest.getCall(graphData, handleError: true).then((v) {
      var  _marketData = conbineList(v[0]["timestamps"],
          v[0]["prices"], (l1, l2) => GraphModel(timestamps: l1, prices: l2));

      // List<GraphModel> _marketData =
      //     v.map<GraphModel>((v) => GraphModel.json(v)).toList();
      return _marketData;
    });
    data.then((v) {
      print(v);
    });

    return Stream.fromFuture(data);
  }
}
