import 'package:bots_app/Actions/getMarketData.dart';
import 'package:bots_app/CustomWidget.dart/bottom_sheet.dart';
import 'package:bots_app/Model/market_model.dart';
import 'package:bots_app/Repository/market_data_repository.dart';
import 'package:bots_app/utils/check_for_svg.dart';
import 'package:bots_app/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(37, 33, 38, 1),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {});
        //   },
        // ),
        body: StreamBuilder<List<MarketModel>>(
            stream: Provider.of<GetMarketData>(
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

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    bottom: PreferredSize(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 15),
                        child: Row(
                          children: [
                            Text(
                              'Markets',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                      preferredSize: const Size(double.infinity, 0),
                    ),
                    pinned: true,
                    expandedHeight: 170,
                    backgroundColor: Color.fromRGBO(36, 30, 31, 1),
                    title: Text("ITEX"),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ...(snapshot.data ?? [])
                            .map((v) => customLisTile(v))
                            .toList()
                      ],
                    ),
                  )
                ],
              );
            }));
  }

  customLisTile(MarketModel data) {
    return InkWell(
      onTap: () => detailDialog(context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 45, width: 45, child: isImageSVG(data.logoUrl)),
              SizedBox(
                height: 10,
              ),
              Text(
                data.name,
                style: TextStyle(fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Text(
                      "${data.name} Market Update ${data.priceDate}  ",
                      style: TextStyle(fontSize: 10),
                    ),
                    Spacer(),
                    Text("13 hour ago")
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Text(
                      "${data.name} Market Update ${data.priceDate}  ",
                      style: TextStyle(fontSize: 10),
                    ),
                    Spacer(),
                    Text("2 days ago")
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Text(
                      "${data.name} Market Update ${data.priceDate}  ",
                      style: TextStyle(fontSize: 10),
                    ),
                    Spacer(),
                    Text("a month ago")
                  ],
                ),
              ),
              Divider(),
            ],
          )),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(height: 30, width: 30, child: isImageSVG(data.logoUrl)),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  data.currency,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$ ${double.parse(data.price).toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  '${double.parse(data.change).toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
    // return ListTile(
    //   leading:
    //   title: Text(data.name),
    //   subtitle: Text("BTC"),
    // );
  }
}
