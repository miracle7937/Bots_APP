
class GraphModel {
  final String timestamps, prices;

  GraphModel({this.timestamps, this.prices});

  factory GraphModel.json(Map map) {
    return GraphModel(timestamps: map['year'], prices: map["value"]);
  }
}

