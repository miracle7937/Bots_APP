import 'package:bots_app/Repository/graph_data_repo.dart';
import 'package:flutter/cupertino.dart';

class GetGraphData with ChangeNotifier {
  final GraphDataRepo repo;

  GetGraphData(this.repo);

  execute() {
    return repo.getALLMarket();
  }
}
