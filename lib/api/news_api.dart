import 'package:http/http.dart' as http;
import 'package:news_app/config/config.dart';
import 'package:news_app/models/news_model.dart';

class NewsApi {
  Future getAllNews() async {
    try {
      Uri url = Uri.parse(
          "${Config.apiBaseUrl}/everything?q=bitcoin&apiKey=30ff354ba1bb4f8a817a9a8b38324afd");
      // api response
      var response = await http.get(
        url,
        headers: {
          // key: value
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return newsModelFromJson(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
