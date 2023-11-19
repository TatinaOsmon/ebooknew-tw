import 'dart:convert';

import 'package:ebooknew/models/ToolResponse.dart';
import 'package:http/http.dart' as http;

class ToolViewModel {
  Future<ToolResponse> getData() async {
    var response = await http
        .get(Uri.parse('https://ebookapi.jizoji.org//toolCategory/findAll'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ToolResponse.fromJson(data);
    } else {
      return throw Exception('Please Try Again later');
    }
  }
}



///Now confirm api
///