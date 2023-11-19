import 'package:http/http.dart' as http;

class AddTOCartViewModel {

  Future addBook(String productId) async {
    var response = await http.post(Uri.parse(''));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return throw Exception('Added to Cart');
    }

    else{
      return throw Exception('Please Try Again!');
    }
  }
}