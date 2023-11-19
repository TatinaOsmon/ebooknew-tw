import 'dart:convert';
import 'package:ebooknew/models/all_book_response.dart';
import 'package:ebooknew/viewmodel/common_view_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookViewModel {
  ViewModel viewModel = Get.put(ViewModel());

  Future<AllBookResponse> getData() async {
    var response = await http.post(
        Uri.parse('https://ebookapi.jizoji.org//bookCategory/findAll'),
        body: jsonEncode({"userId": viewModel.userId.value}));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return AllBookResponse.fromJson(data);
    } else {
      return throw Exception('Error');
    }
  }
}
