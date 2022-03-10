import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkingData {
  NetworkingData(this.url);
  final String url;

  getNetworkData() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
