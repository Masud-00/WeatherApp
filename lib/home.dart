import 'package:flutter/material.dart';
import 'package:weatherapp/weather.dart';
import 'package:weatherapp/weather_api.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  WeatherApi clint = WeatherApi();
  Weather? data;
  String? city = 'delhi';

  Future<void> getdata(String? city) async {
    if(city!.isNotEmpty) {
      data = await clint.getData(city);
    }
  }

  String? _imageUrl() {
    switch (data?.description) {
      case 'clear sky':
        return 'http://openweathermap.org/img/wn/01d.png';
      case 'few clouds':
        return 'http://openweathermap.org/img/wn/02d.png';
      case 'scattered clouds':
        return 'http://openweathermap.org/img/wn/03d.png';
      case 'broken clouds':
        return 'http://openweathermap.org/img/wn/04d.png';
      case 'shower rain':
        return 'http://openweathermap.org/img/wn/09d.png';
      case 'rain':
        return 'http://openweathermap.org/img/wn/10d.png';
      case 'thunderstorm':
        return 'http://openweathermap.org/img/wn/11d.png';
      case 'snow':
        return 'http://openweathermap.org/img/wn/13d.png';
      case 'mist':
        return 'http://openweathermap.org/img/wn/50d.png';
    }
  }

  @override
  void initState() {
    super.initState();
    city = 'delhi';
    getdata(city);
  }

  TextEditingController _cityname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
          title: Text(
            "Weather App",
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(children: [
              TextField(
                controller: _cityname,
                decoration: InputDecoration(
                  labelText: 'City name',
                  hintText: 'Enter city name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      city = _cityname.text;
                      _cityname.clear();
                    });
                  },
                  color: Colors.lightBlueAccent,
                  child: Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  )),
              FutureBuilder(
                  future: getdata(city),
                  builder: (context, snapshot) {
                    if(data==null){
                      return Container(
                        margin: EdgeInsets.only(top: 40.0),
                        alignment: Alignment.center,
                        child: Text("No city exits in this name",style: TextStyle(fontSize: 30.0),),
                      );
                    }
                    else if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.lightBlueAccent,
                                ),
                                color: Colors.blueAccent[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                              ),
                              child: Image.network(
                                _imageUrl() ??
                                    'http://openweathermap.org/img/wn/01d.png',
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Text(
                              data?.location != null
                                  ? '${data?.location}'
                                  : 'Loading..',
                              style:
                                  TextStyle(fontSize: 20.0, letterSpacing: 2,color: Colors.black),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              data?.temp != null
                                  ? '${data?.temp} °C'
                                  : 'Loading..',
                              style: TextStyle(
                                fontSize: 40.0,
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              data?.description != null
                                  ? '${data?.description}'
                                  : 'Loading..',
                              style:
                                  TextStyle(fontSize: 20.0, letterSpacing: 2,color: Colors.black),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Feels like ${data?.feels_like} °C",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  letterSpacing: 2,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(9.0),
                                  alignment: Alignment.center,
                                  height: 120.0,
                                  width: 100.0,
                                  child: Text(
                                    "Max temp ${data?.max_temp} °C",
                                    style: TextStyle(fontSize: 18.0,color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue[100],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  height: 120.0,
                                  width: 100.0,
                                  child: Text(
                                    "Min temp  ${data?.min_temp} °C",
                                    style: TextStyle(fontSize: 18.0,color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue[100],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  height: 120.0,
                                  width: 100.0,
                                  child: Text("Humidity  ${data?.humidity} %",
                                      style: TextStyle(fontSize: 18.0,color: Colors.black),
                                      textAlign: TextAlign.center),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue[100],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  height: 120.0,
                                  width: 100.0,
                                  child: Text("pressure ${data?.pressure}",
                                      style: TextStyle(fontSize: 18.0,color: Colors.black),
                                      textAlign: TextAlign.center),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue[100],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  height: 120.0,
                                  width: 100.0,
                                  child: Text('Wind  ${data?.wind_speed}km/hr',
                                      style: TextStyle(fontSize: 18.0,color: Colors.black),
                                      textAlign: TextAlign.center),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue[100],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  height: 120.0,
                                  width: 100.0,
                                  child: Text('Clouds  ${data?.cloud} %',
                                      style: TextStyle(fontSize: 18.0,color: Colors.black),
                                      textAlign: TextAlign.center),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue[100],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
            ]),
          ),
        ));
  }
}
