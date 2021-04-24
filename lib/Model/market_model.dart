import 'package:intl/intl.dart';

class MarketModel {
  final String currency, name, logoUrl, price, priceDate, change;

  MarketModel(
      {this.currency,
      this.name,
      this.logoUrl,
      this.price,
      this.priceDate,
      this.change});

  factory MarketModel.json(Map map) {
    return MarketModel(
        currency: map["currency"],
        name: map["name"],
        logoUrl: map["logo_url"],
        price: map["price"],
        change: map["1d"]["price_change_pct"],
        priceDate: formatDate(DateTime.parse(map["price_date"])));
  }
}

String formatDate(DateTime date) => new DateFormat("MMMM d").format(date); //fo
