import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();

  GoogleMapController mapController;
  final LatLng _center = const LatLng(11.165225296068185, 107.97949156398727);
  ui.Image image;
  LatLng centerPosition;
  Set<Marker> markers = Set();

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _controller.complete(controller);
    await _onAddMarkerButtonPressed();

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(getBounds(markers), 30);
    this.mapController.animateCamera(u2).then((void v) {
      check(u2, this.mapController);
    });
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  LatLngBounds getBounds(Set<Marker> markers) {
    if (markers.length == list.length) {
      var lngs = markers.map<double>((m) => m.position.longitude).toList();
      var lats = markers.map<double>((m) => m.position.latitude).toList();

      double topMost = lngs.reduce(max);
      double leftMost = lats.reduce(min);
      double rightMost = lats.reduce(max);
      double bottomMost = lngs.reduce(min);

      LatLngBounds bounds = LatLngBounds(
        northeast: LatLng(rightMost, topMost),
        southwest: LatLng(leftMost, bottomMost),
      );

      return bounds;
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    // _onAddMarkerButtonPressed();
    // getBounds(markers);
  }

  var paint = new Paint();

  Future<Null> init() async {
    final ByteData data = await rootBundle.load('images/icon.png');
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      // setState(() {
      //   isImageloaded = true;
      // });
      return completer.complete(img);
    });
    return completer.future;
  }

  String getName(String name) {
    String firstName = "";
    var names = name.split(' ');
    if (names.length > 1) {
      firstName = names[names.length - 1];
    } else {
      firstName = names[1];
    }
    return firstName;
  }

  Future _onAddMarkerButtonPressed() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('images/icon.png', 100);
    for (int i = 0; i < list.length; i++) {
      InfoWindow infoWindow = InfoWindow(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ProfilePage()),
          // );
        },
        title: list[i]["name"],
        snippet: list[i]["title"],
      );

      ui.PictureRecorder recorder = new ui.PictureRecorder();
      Canvas c = new Canvas(recorder);

      /* Do your painting of the custom icon here, including drawing text, shapes, etc. */
      TextSpan span = new TextSpan(
        style: new TextStyle(
          color: Colors.blue,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
        ),
        text: getName(
          list[i]["name"],
        ),
        // text: list[i]["name"],
      );

      TextSpan spantext = new TextSpan(
        style: new TextStyle(
          color: Colors.blue,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
        ),
        text: "Status",
      );

      TextPainter tp = new TextPainter(
        text: span,
        // textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      // TextPainter text = new TextPainter(
      //   text: spantext,
      //   textAlign: TextAlign.start,
      //   textDirection: TextDirection.ltr,
      // );
      //  ByteData data =await image.toByteData();
      c.drawImage(image, Offset.zero, Paint());
      // text.layout();
      // text.paint(c, new Offset(00.0, 220.0));
      tp.layout();
      tp.paint(c, new Offset(10.0, 70.0));
      ui.Picture p = recorder.endRecording();
      ByteData pngBytes =
          await (await p.toImage(tp.width.toInt() + 10, tp.height.toInt() + 60))
              .toByteData(format: ui.ImageByteFormat.png);
      Uint8List data = Uint8List.view(pngBytes.buffer);

      Marker marker = Marker(
        markerId: MarkerId(
          list[i]["id"],
        ),
        infoWindow: infoWindow,
        position: LatLng(list[i]["Latitude"], list[i]["Longitude"]),
        icon: BitmapDescriptor.fromBytes(data),

        //  icon: BitmapDescriptor.fromBytes(markerIcon),
      );

      setState(() {
        markers.add(marker);
      });
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  var list = [
    {
      'name': 'bui hong vinh',
      'title': 'i am good',
      'id': '1',
      'Latitude': 10.771423,
      'Longitude': 106.698471
    },
    {
      'name': 'bui hong',
      'title': 'i am good',
      'id': '2',
      'Latitude': 11.0266670507584,
      'Longitude': 108.1230498447585
    },
    {
      'name': 'bui  vinh',
      'title': 'i am good',
      'id': '3',
      'Latitude': 11.049344894248165,
      'Longitude': 108.15367599916294
    },
    {
      'name': 'hong vinh',
      'title': 'i am good',
      'id': '4',
      'Latitude': 11.165225296068185,
      'Longitude': 107.97949156398727
    },
    {
      'name': 'hong vinh1',
      'title': 'i am good',
      'id': '5',
      'Latitude': 13.736717,
      'Longitude': 100.523186
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height / 13,
          child: GoogleMap(
            trafficEnabled: true,
            markers: markers,
            onMapCreated: _onMapCreated,
            onCameraMove: _onCameraMove,
            initialCameraPosition: CameraPosition(target: (_center), zoom: 7.5),
          ),
        )
      ],
    );
  }

  void _onCameraMove(CameraPosition position) {
    centerPosition = position.target;
  }
}
