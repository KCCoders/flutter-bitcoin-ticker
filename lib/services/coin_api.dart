import 'package:bitcoin_ticker/constants.dart';
import 'network_helper.dart';

class CoinAPI {
  Future<dynamic> getExchangeRate(String crypto, String currency) async {
    String url = '$kCoinIoBaseUrl/$crypto/$currency?apiKey=$kCoinIoApiKey';
    log(url);
    NetworkHelper networkHelper = NetworkHelper(url: url);
    return await networkHelper.getData();
  }
}
