import 'package:allerternatives/models/marker.dart';
import 'package:allerternatives/ui/shared/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCarousel extends StatefulWidget {
  final MyMarker marker;

  MyCarousel({this.marker});

  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselSlider(
          items: getWidgets(),
          options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              aspectRatio: 1.5,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.marker.items.map((item) {
            int index = widget.marker.items.indexOf(item);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? primaryColor : lightGreyText,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  List<Widget> getWidgets() {
    List<Widget> imageSliders = new List<Widget>();
    List<String> temp = ["firstWidget"];
    DateTime now = new DateTime.now();
    DateTime open = new DateTime(now.year, now.month, now.day,
        widget.marker.openHour, widget.marker.openMinute);
    DateTime close = new DateTime(now.year, now.month, now.day,
        widget.marker.closeHour, widget.marker.closeMinute);
    String openNow = now.isAfter(open) && now.isBefore(close)
        ? "Open  *  Closes at ${TimeOfDay.fromDateTime(close).format(context)}"
        : "Closed  *  opens at ${TimeOfDay.fromDateTime(open).format(context)}";
    openNow = open == close ? "Open 24 Hours" : openNow;
    List<Widget> firstImage = temp
        .map((e) => SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.width * .26,
            child: Container(
              child: Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: primaryColorLight,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.marker.name,
                          style: TextStyle(
                            color: darkGreyText,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .6,
                          child: Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .30,
                                    child: Text(
                                      "${widget.marker.address}",
                                      style: TextStyle(
                                        color: lightGreyText,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .28,
                                    child: Text(
                                      "${widget.marker.distance} ${widget.marker.units}",
                                      style: TextStyle(
                                        color: lightGreyText,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .28,
                                    child: Text(
                                      "$openNow",
                                      style: TextStyle(
                                        color: lightGreyText,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topRight,
                                    width:
                                        MediaQuery.of(context).size.width * .27,
                                    height:
                                        MediaQuery.of(context).size.width * .18,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "assets/markerImages/${widget.marker.markerID}.jpg"),
                                    )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox.fromSize(
                                          size: Size(50, 50),
                                          child: ClipOval(
                                              child: Material(
                                            color: primaryColor,
                                            // button color
                                            child: InkWell(
                                              splashColor: primaryColorLight,
                                              // splash color
                                              onTap: () {
                                                _launchURL(
                                                    "tel://${widget.marker.phone}");
                                              },
                                              // button pressed
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.call,
                                                    color: lightGreyText,
                                                  ), // icon
                                                  Text(
                                                    "Call",
                                                    style: TextStyle(
                                                        color: lightGreyText),
                                                  ), // text
                                                ],
                                              ),
                                            ),
                                          ))),
                                      SizedBox(width: 10),
                                      SizedBox.fromSize(
                                          size: Size(50, 50),
                                          child: ClipOval(
                                              child: Material(
                                            color: primaryColor,
                                            // button color
                                            child: InkWell(
                                              splashColor: primaryColorLight,
                                              // splash color
                                              onTap: () {
                                                MapsLauncher.launchQuery(
                                                    '${widget.marker.address}');
                                              },
                                              // button pressed
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.location_on,
                                                    color: lightGreyText,
                                                  ), // icon
                                                  Text(
                                                    "Maps",
                                                    style: TextStyle(
                                                        color: lightGreyText),
                                                  ), // text
                                                ],
                                              ),
                                            ),
                                          )))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        //  ${widget.marker.distance} ${widget.marker.units}
                      ])),
            )))
        .toList();
    List<Widget> otherImages = widget.marker.items
        .map((item) => SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Container(
                child: Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * .35,
                          height: MediaQuery.of(context).size.height * .10,
                          decoration: BoxDecoration(
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(12.0),
                                  topRight: const Radius.circular(12.0),
                                  bottomLeft: const Radius.circular(12.0),
                                  bottomRight: const Radius.circular(12.0)),
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                    "assets/markerImages/${item.name}.jpg"),
                              )),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .6,
                          child: Text(
                            item.name,
                            style: TextStyle(
                              color: darkGreyText,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          item.description,
                          style: TextStyle(
                            color: lightGreyText,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    )),
              ),
            ))
        .toList();
    imageSliders.addAll(firstImage);
    imageSliders.addAll(otherImages);
    return imageSliders;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
