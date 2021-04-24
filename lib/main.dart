import 'package:bots_app/Actions/getMarketData.dart';
import 'package:bots_app/Actions/get_graph_data.dart';
import 'package:bots_app/Pages/dashoard.dart';
import 'package:bots_app/Pages/graph_screen.dart';
import 'package:bots_app/Repository/graph_data_repo.dart';
import 'package:bots_app/Repository/market_data_repository.dart';
import 'package:bots_app/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => GetMarketData(
                MarketDataRepoImplementaion(httpRequest: HttpRequest()))),
        ChangeNotifierProvider(
            create: (_) => GetGraphData(
                GraphDataRepoImplementaion(httpRequest: HttpRequest()))),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainScreen()),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    GraphScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List tabs = [
    {
      'label': 'HOME',
      'image': FontAwesomeIcons.home,
    },
    {
      'label': 'Graph',
      'image': FontAwesomeIcons.chartBar,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(37, 33, 38, 1),
        items: tabs.map((value) {
          return BottomNavigationBarItem(
              title: Text(value['label']),
              icon: FaIcon(
                value['image'],
              ));
        }).toList(),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
