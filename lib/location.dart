import 'package:geolocator/geolocator.dart';

class GetLocation{

  void getLocations() async{
    await Geolocator.isLocationServiceEnabled();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }


  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission locationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
     return await Geolocator.getCurrentPosition();
  }

}