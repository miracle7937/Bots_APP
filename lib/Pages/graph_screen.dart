import 'package:bots_app/Actions/getMarketData.dart';
import 'package:bots_app/Actions/get_graph_data.dart';
import 'package:bots_app/Model/graph_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);
    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops);
    return Scaffold(
      backgroundColor: Color.fromRGBO(37, 33, 38, 1),
        body: StreamBuilder<List<GraphModel>>(
            stream: Provider.of<GetGraphData>(
              context,
            ).execute(),
            builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )),
                );
              }
              return Center(
                  child: Container(
                      child: SfCartesianChart(
                          backgroundColor: Color.fromRGBO(36, 30, 31, 1),
                          primaryXAxis: DateTimeAxis(),
                          series: <ChartSeries>[
                    // Renders line chart
                    AreaSeries<GraphModel, dynamic>(
                      gradient: gradientColors,
                      dataSource: snapshot.data,
                      xValueMapper: (GraphModel sales, _) =>
                          DateTime.parse(sales.timestamps),
                      yValueMapper: (GraphModel sales, _) =>
                          double.parse(sales.prices),
                    )
                  ])));
            }));
  }
}
