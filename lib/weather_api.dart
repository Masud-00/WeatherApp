import 'package:http/http.dart';
import 'package:weatherapp/weather.dart';
import 'dart:convert';
class WeatherApi{

  Future<Weather?> getData(String? location) async {
    try {
      var api = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=6104951eb506fcbad5ae3df555569890&units=metric');
      Response response = await get(api);
      var body = jsonDecode(response.body);
      return Weather.formJson(body);
    }
    catch(e){

    }
  }



}