import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:latlong/latlong.dart";

class GeoCoding {


  Future<Position> getCurrentPosition() async
  {
    LocationPermission permission = await Geolocator.checkPermission();
    bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    Position position = new Position(latitude: 0,longitude: 0);
    if(isLocationServiceEnabled)
    {
      if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever)
      {

        permission = await Geolocator.requestPermission();

      }else{

        position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      }

    }else {

      print("is disabled");

    }


    return position;
  }


  Future<List<Placemark>> reverseGeocode(double lat,double lng) async {

    return await placemarkFromCoordinates(lat, lng);
   }

  Future<LatLng> geocode(String address) async {

    try{

      List<Location> locations = await locationFromAddress(address);
      return LatLng(locations.first.latitude,locations.first.longitude);

    } on Exception
    {
      return LatLng(0, 0);

    }

  }
}
