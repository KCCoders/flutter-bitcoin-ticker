import 'dart:developer';
import 'package:bitcoin_ticker/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  final String url;

  NetworkHelper({this.url});

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    print(response);

    if (response.statusCode == 200) {
      String data = response.body;
      return convert.jsonDecode(data);
    } else {
      log(response.statusCode.toString());
      log(response.body);
    }
  }
}
