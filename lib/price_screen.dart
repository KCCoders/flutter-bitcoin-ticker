import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/services/coin_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCrypto = 'BTC';
  String btcExchangeRate = '\$100.00';
  String ethExchangeRate = '\$100.00';
  String ltcExchangeRate = '\$100.00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getExchangeRates();
  }

  void getExchangeRates() {
    kCryptoList.forEach((crypto) {
      getExchangeRate(crypto);
    });
  }

  void getExchangeRate(String crypto) async {
    var data = await CoinAPI().getExchangeRate(crypto, selectedCurrency);
    updateUI(data, crypto);
  }

  void updateUI(dynamic data, String crypto) {
    setState(() {
      if (data == null) {
        return;
      }
      double rate = data['rate'];

      switch (crypto) {
        case 'BTC':
          btcExchangeRate = rate.toStringAsFixed(2);
          break;
        case 'ETH':
          ethExchangeRate = rate.toStringAsFixed(2);
          break;
        case 'LTC':
          ltcExchangeRate = rate.toStringAsFixed(2);
          break;
      }
    });
  }

  DropdownButton<String> getAndroidDropdown() {
    var items = List<DropdownMenuItem<String>>();

    kCurrenciesList.forEach((item) {
      items.add(
        DropdownMenuItem<String>(
          child: Text(item),
          value: item,
        ),
      );
    });

    return DropdownButton<String>(
      value: selectedCurrency,
      items: items,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getExchangeRates();
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    var items = List<Text>();
    kCurrenciesList.forEach((item) {
      items.add(Text(item));
    });
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(
          () {
            selectedCurrency = kCurrenciesList[selectedIndex];
            getExchangeRates();
          },
        );
      },
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcExchangeRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethExchangeRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $ltcExchangeRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getAndroidDropdown(),
          ),
        ],
      ),
    );
  }
}
