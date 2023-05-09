import 'dart:convert';

import 'package:http/http.dart' as http;

class Networkget {
  String Url = 'https://fakestoreapi.com/products';

  Future getData() async {
    try {
      return await http.get(Uri.parse(Url)).then((value) {
        return jsonDecode(value.body);
      });
    } catch (E) {
      return [];
    }
  }
}
