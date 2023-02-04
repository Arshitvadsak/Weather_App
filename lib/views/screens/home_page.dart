import 'package:flutter/material.dart';
import '../../helpers/api_helpers.dart';
import '../../models/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  late Future<Weather?> getData;

  @override
  void initState() {
    super.initState();
    getData = APIHelper.apiHelper.fetchWeatherData();
  }

  var Style = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 750,
          width: 360,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    flex: 10,
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Search by City Name...",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.black54),
                      ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        String searchedCity = searchController.text;
                        setState(() {
                          getData = APIHelper.apiHelper
                              .fetchWeatherData(city: searchedCity);
                        });
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 7,
                child: FutureBuilder(
                  future: getData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error : ${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      Weather? data = snapshot.data;

                      return (data != null)
                          ? Column(
                              children: [
                                Container(
                                  height: 330,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      image: (data.description == "Smoke" ||
                                              data.main == "Haze" ||
                                              data.main == "Fog")
                                          ? const DecorationImage(
                                              image: AssetImage(
                                                  'assets/gif/4791-foggy.gif'),
                                              fit: BoxFit.cover,
                                            )
                                          : (data.main == "Clouds")
                                              ? const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/gif/35631-weather-day-scattered-clouds.gif'),
                                                  fit: BoxFit.cover,
                                                )
                                              : (data.main == "Clear")
                                                  ? const DecorationImage(
                                                      image: AssetImage(
                                                          'assets/gif/50658-light-snow-to-clear-up.gif'),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : (data.main == "Rain")
                                                      ? const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/gif/36561-rain-and-windy.gif'),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : (data.main ==
                                                              "Thunderstorm")
                                                          ? const DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/gif/4792-weather-stormshowersday.gif'),
                                                              fit: BoxFit.cover,
                                                            )
                                                          : (data.main ==
                                                                  "Snow")
                                                              ? const DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/gif/animation_500_ldogv8xv.gif'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : const DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/gif/35743-weather-day-snow.gif'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${data.temp}",
                                            style: const TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          const Text(
                                            "℃",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${data.main}",
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Icon(
                                                  Icons.build_circle_outlined,
                                                  color: Colors.black),
                                              Text(
                                                (searchController.text != "")
                                                    ? '   ${searchController.text} 📌'
                                                    : ("Surat 📌"),
                                                style: Style,
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.local_airport,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Column(
                                  children: [
                                    Text(
                                      "Weather Report",
                                      style: Style,
                                    ),
                                    const Text(
                                      "-----------------",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                              elevation: 3,
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 40,
                                                child: Text(
                                                  "temperature :  ${data.temp} ",
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Card(
                                              elevation: 3,
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 40,
                                                child: Text(
                                                  "Wind Speed :  ${data.speed} ",
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Card(
                                              elevation: 3,
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 40,
                                                child: Text(
                                                  "Humidity :  ${data.humidity} ",
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Contry :- ${data.country}",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            )
                          : const Center(
                              child: Text("No data found..."),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
