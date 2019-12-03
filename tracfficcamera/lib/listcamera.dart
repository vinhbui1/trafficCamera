import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListCammera extends StatefulWidget {
  @override
  _ListCammeraState createState() => _ListCammeraState();
}

class _ListCammeraState extends State<ListCammera> {
  String _now;

  Timer _timer;
  Image image;
  @override
  void initState() {
    _now = DateTime.now().millisecondsSinceEpoch.toString();
    imageCache.clear();
    image = Image.network(
        "http://giaothong.hochiminhcity.gov.vn/render/ImageHandler.ashx?id=56df8381c062921100c143e2" +
            "?v=$_now");
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        print(_now);
        _now = DateTime.now().millisecondsSinceEpoch.toString();
        imageCache.clear();
        image = Image.network(
            "http://giaothong.hochiminhcity.gov.vn/render/ImageHandler.ashx?id=56df8381c062921100c143e2" +
                "?v=$_now");
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }

  Widget containterContent() {
    return Container(
        // width: MediaQuery.of(context).size.width,

        height: MediaQuery.of(context).size.height,
        color: Colors.cyanAccent,
        margin: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width - 100,
        child: Center(
          child: Text("asdasdassad"),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[image,containterContent()
      ],
      // color: Colors.black,
    );
  }
}
