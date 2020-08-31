import 'dart:async';
import 'dart:convert';

import 'package:allerternatives/Services/auth.dart';
import 'package:allerternatives/models/marker.dart';
import 'package:allerternatives/ui/main/home/carousel.dart';
import 'package:allerternatives/ui/shared/app_colors.dart';
import 'package:allerternatives/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool toggle;
  Completer<GoogleMapController> _controller = Completer();
  final AuthService _auth = AuthService();
  TextEditingController searchController = TextEditingController();
  Position _currentPosition;
  double zoomVal = 5.0;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor everyLocationIcon;
  Set<Marker> _markers = {};
  List<MyMarker> _stores;
  List<MyMarker> _restaurants;
  List<MyMarker> _choice;
  LatLng _pinPosition;
  bool openView = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    setCustomMapPin();
    parseJson();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
            elevation: 0.0,
            title:
                Text('Aller-Ternatives', style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text('Log Out', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: _currentPosition != null
              ? Stack(
                  children: <Widget>[
                    _googleMap(context, _currentPosition),
                    _upperZone(context),
                    openView ? _buildContainer(context) : Container(),
                  ],
                )
              : Loading()),
    );
  }

  // Widgets
  Widget _googleMap(BuildContext context, Position currentPosition) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new GoogleMap(
          mapType: MapType.normal,
          markers: _markers,
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(currentPosition.latitude, currentPosition.longitude),
              zoom: 12),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);

            setState(() {
              _markers.add(Marker(
                markerId: MarkerId('usersLocation'),
                position: _pinPosition,
                icon: pinLocationIcon,
              ));
            });
          },
        ));
  }

  Widget _upperZone(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: 50.0,
                  child: TextField(
                    controller: searchController,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      hintText: 'Search',
                    ),
                    onChanged: (text) {
                      // do nothing
                    },
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                ClipOval(
                  child: Material(
                    color: primaryColor,
                    child: InkWell(
                      splashColor: Theme.of(context).primaryColorLight,
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: new Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                      onTap: () async {
                        _showSelection(context);
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .6 + 70,
              child: Align(
                alignment: Alignment.centerRight,
                child: ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20,
                    activeBgColor: primaryColor,
                    activeFgColor: Colors.white,
                    inactiveBgColor: primaryColorLight,
                    inactiveFgColor: primaryColor,
                    labels: ['Grocery', 'Restaurant'],
                    onToggle: (index) {
                      _toggleList();
                    }),
              ),
            )
          ],
        ));
  }

  Widget _buildContainer(BuildContext context) {
    return Dismissible(
      key: Key("MyWidget"),
      direction: DismissDirection.down,
      onDismissed: (direction) {
        setState(() {
          openView = false;
        });
      },
      child: DraggableScrollableSheet(
        initialChildSize: .44,
        minChildSize: .44,
        maxChildSize: .84,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 50.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                      color: lightGreyText,
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    itemCount: _choice.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: MyCarousel(
                        marker: _choice[index],
                      ));
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // Functions

  _getCurrentLocation() {
    final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;

    geoLocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _pinPosition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/UserLocation.png');
    everyLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/Location.png');
  }

  Future<String> _loadFromAsset1() async {
    return await rootBundle.loadString("assets/data/stores.json");
  }

  Future<String> _loadFromAsset2() async {
    return await rootBundle.loadString("assets/data/restaurants.json");
  }

  Future parseJson() async {
    String jsonString1 = await _loadFromAsset1();
    String jsonString2 = await _loadFromAsset2();
    _stores = (json.decode(jsonString1) as List)
        .map((i) => MyMarker.fromJson(i))
        .toList();

    _restaurants = (json.decode(jsonString2) as List)
        .map((i) => MyMarker.fromJson(i))
        .toList();

    toggle = true;
    _choice = _stores;
  }

  void _toggleList() {
    setState(() {
      if (toggle) {
        _choice = _restaurants;
        toggle = false;
      } else {
        _choice = _stores;
        toggle = true;
      }
    });
  }

  void _showSelection(BuildContext context) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('usersLocation'),
        position: _pinPosition,
        icon: pinLocationIcon,
      ));

      _choice.forEach((element) {
        _markers.add(Marker(
            infoWindow: InfoWindow(title: element.name),
            markerId: MarkerId(element.markerID),
            position: LatLng(element.lat, element.lng),
            icon: everyLocationIcon,
            onTap: () async {
              setState(() {
                buildBottomSheet(context, element);
              });
            }));
      });
      openView = true;
    });
  }

  int _findIndex(String markerId) {
    return _choice.indexWhere((element) => element.markerID == markerId);
  }

  void buildBottomSheet(BuildContext context, MyMarker element) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .42,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 50.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                        color: lightGreyText,
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyCarousel(
                    marker: _choice[_findIndex(element.markerID)],
                  )
                ],
              ),
            ));
  }
}

/*





 */
