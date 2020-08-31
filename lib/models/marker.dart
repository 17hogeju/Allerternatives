import 'dart:convert';

import 'package:allerternatives/models/menu_item.dart';

MyMarker fromJson(String str) => MyMarker.fromJson(json.decode(str));

class MyMarker {
  double lat;
  double lng;
  String markerID;
  String name;
  String address;
  double distance;
  String units;
  int openHour;
  int openMinute;
  int closeHour;
  int closeMinute;
  double rating;
  int numRatings;
  String phone;
  int numDollars;

  List<MenuItem> items;

  MyMarker(
      {this.lat,
      this.lng,
      this.markerID,
      this.name,
      this.address,
      this.distance,
      this.units,
      this.openHour,
      this.openMinute,
      this.closeHour,
      this.closeMinute,
      this.rating,
      this.numRatings,
      this.phone,
      this.numDollars,
      this.items});

  factory MyMarker.fromJson(Map<String, dynamic> json) {
    var menuItemList = json['items'] as List;
    List<MenuItem> finalList =
        menuItemList.map((i) => MenuItem.fromJson(i)).toList();

    return MyMarker(
        lat: json['lat'],
        lng: json['lng'],
        markerID: json['markerID'],
        name: json['name'],
        address: json['address'],
        distance: json['distance'],
        units: json['units'],
        openHour: json['openHour'],
        openMinute: json['openMinute'],
        closeHour: json['closeHour'],
        closeMinute: json['closeMinute'],
        rating: json['rating'],
        numRatings: json['numRatings'],
        phone: json['phone'],
        numDollars: json['numDollars'],
        items: finalList);
  }
}
