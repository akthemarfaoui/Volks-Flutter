import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";
import 'package:volks_demo/API/GeoCoding.dart';
import 'package:volks_demo/Utils/MyColors.dart';

class MapView extends StatefulWidget {
  double lat = 0;
  double long = 0;
  String address = "";

  MapView.setLatLong(this.lat, this.long);
  MapView.setAddress(this.address);

  @override
  MapViewState createState() => new MapViewState();
}

class MapViewState extends State<MapView> {
  double latCoord, lngCoord;
  bool loading=true;
  bool notFound = false;
  GeoCoding geoCoding = GeoCoding();

  Future<LatLng> getCoordinates() {
    double lat = 0, lng = 0;
    if (widget.lat != 0 && widget.long != 0) {
      lat = widget.lat;
      lng = widget.long;
    } else if (widget.address != "") {
      return geoCoding.geocode(widget.address);
    }

    return Future.value(LatLng(lat, lng));
  }


  Widget NotFoundAlert(BuildContext context)
  {

      return new AlertDialog(
      title: Text("Address Not Found"),
      content: Text("cannot find address: "+ widget.address),
      actions: [
        FlatButton(
            onPressed: () {
              setState(() {

                Navigator.of(context, rootNavigator: true)
                    .pop(false);

              });


            },
            child: Text("Ok")),
      ],
    );

  }

  @override
  void initState() {
    super.initState();

    getCoordinates().then((value) {
      setState(() {
        print(value);
        if(value.latitude == 0 && value.longitude == 0 )
          notFound = true;
        latCoord = value.latitude;
        lngCoord = value.longitude;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: notFound ? NotFoundAlert(context) : loading ? Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(MyColors.PostColor)),
      ): FlutterMap(
        options: MapOptions(
          center: LatLng(latCoord, lngCoord),
          minZoom: 10.0,
          zoom: 13.0,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 45.0,
                height: 45.0,
                point: new LatLng(latCoord, lngCoord),
                builder: (context) => new Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 45.0,
                    onPressed: () => print("sssss"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
