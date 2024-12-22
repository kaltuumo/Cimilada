import 'package:cimilo/services/location.dart';
import 'package:cimilo/services/networking.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';

const apikey = 'e72ca729af228bebd5d20e3b7749713';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  void initSate() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey');

    var wheatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: wheatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoadingScreenData(),
    );
  }
}

class _LoadingScreenData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
