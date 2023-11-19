import 'dart:convert';

import 'package:ebooknew/viewmodel/common_view_model.dart';
import 'package:get/get.dart';

import '../models/BookVersionResponse.dart';
import 'package:http/http.dart' as http;

class BookVersionViewModel {
  ViewModel viewModel = Get.put(ViewModel());

  Future<BookVersionResponse> apiData(String id) async {
    var response =
        await http.post(Uri.parse('https://ebookapi.jizoji.org//book/findAll'),
            body: jsonEncode({
              "userId": viewModel.userId.value,
              "jwtToken": viewModel.jwtToken.value,
              "refreshToken": viewModel.refreshToken.value,
              "id": id
            }));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return BookVersionResponse.fromJson(data);
    } else {
      return throw Exception('Plese Try Again Later!!!');
    }
  }
}
