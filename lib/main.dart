import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    title: 'Horizonal slider',
    home: Notifications(),
  ));
}

class Notifications extends StatefulWidget {
  @override
  NotificationsState createState() => new NotificationsState();
}

class NotificationsState extends State<Notifications> {
  List data;

  Future<String> getData() async {
    var response = await http
        .get(Uri.encodeFull("http://booking.sreyas.net/api/sliderData"));

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Notifications"),
            backgroundColor: Colors.pinkAccent),
        body: secondImageSlider());
  }

  Widget secondImageSlider() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        var imageInitialUrl = "http://booking.sreyas.net";
        String imageUrl = imageInitialUrl + data[index]["imgUrl"];
        return Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Card(
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Expanded(
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          new Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              "movie name",
                              style: new TextStyle(
                                  fontSize: 16.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Roboto"),
                              maxLines: 1,
                            ),
                          )
                        ]),
                  ),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 8,
                ),
              ],
            ),
//                        new Container(
//                          alignment: Alignment.bottomLeft,
//                          child: Text(
//                            "Movie one",
//                            style: TextStyle(
//                                fontSize: 14.0, color: Colors.black),
//                          ),
//                        )
          ],
        );
      },
    );
  }
}
