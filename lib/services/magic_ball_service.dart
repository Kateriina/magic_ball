import 'package:http/http.dart' as http;

class MagicBallService {
  Future<String> getMagicAnswer() async {
    final response = await http.get(Uri.parse('https://eightballapi.com/api'));
    if (response.statusCode == 200) {
      return response.body
          .replaceAll('{"reading":"', '')
          .replaceAll('."}', ''); 
    } else {
      throw Exception('Failed to fetch answer');
    }
  }
}
