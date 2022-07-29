class Weather{
  double? temp;
  String? description;
  String? location;
  double? feels_like;
  double? min_temp;
  double? max_temp;
  int? humidity;
  int? pressure;
  double? wind_speed;
  int? cloud;

  Weather({this.temp,this.description,this.location,this.feels_like,this.min_temp,this.max_temp,this.humidity,this.pressure,this.wind_speed,this.cloud});
  Weather.formJson(Map<String,dynamic>json){
    temp=json["main"]["temp"];
    description=json["weather"][0]["description"];
    location=json["name"];
    feels_like=json["main"]["feels_like"];
    min_temp=json["main"]["temp_min"];
    max_temp=json["main"]["temp_max"];
    humidity=json["main"]["humidity"];
    pressure=json["main"]["pressure"];
    wind_speed=json["wind"]["speed"];
    cloud=json["clouds"]["all"]!!;
  }
}