import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<Weather?> fetchWeatherData({String city = 'surat'}) async {
    String apiKey = "ebfd27638d70714dd6f624b7bc9650fb";
    String api = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";

    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);

      print("ok");

      Weather weather = Weather.fromMap(data: decodedData);

      return weather;
    }
    return null;

  }
}
