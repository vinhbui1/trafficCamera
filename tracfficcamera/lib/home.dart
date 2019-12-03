import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:tracfficcamera/detailcamera.dart';
import 'package:tracfficcamera/listcamera.dart';
import 'package:tracfficcamera/map.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  bool _showAppbar = true; //this is to show app bar
  ScrollController _scrollBottomBarController =
      new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  bool _show = true;
  double bottomBarHeight = 75; // set bottom bar height
  double _bottomBarOffset = 0;
  @override
  void initState() {
    super.initState();
    myScroll();
  }

  final List<Widget> _children = [
    MapView(),
    ListCammera(),
    ListCamera(),
  ];
  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    super.dispose();
  }

  void showBottomBar() {
    setState(() {
      _show = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _show = false;
    });
  }

  void myScroll() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          showBottomBar();
        }
      }
    });
  }

  Widget containterContent() {
    return Container(
        // width: MediaQuery.of(context).size.width,

        height: MediaQuery.of(context).size.height,
        color: Colors.cyanAccent,
        margin: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width - 100,
        child: Center(
          child: MapView(),
        ));
  }

  Widget containterContent1() {
    return Container(
        // width: MediaQuery.of(context).size.width,

        height: MediaQuery.of(context).size.height,
        color: Colors.cyanAccent,
        margin: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width - 100,
        child: Center(
          child: ListCammera(),
        ));
  }

  Widget body(int index) {
    if (index == 0) {
      return Container(
        child: _children[index],
      );
    } else {
      return ListView(
        controller: _scrollBottomBarController,
        children: <Widget>[
          _children[index],
        ],
      );
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Widget containterContent2() {
      return Container(
        height: height,
        width: width,
        color: Colors.cyanAccent,
        margin: EdgeInsets.all(8.0),
        child: MapView(),
      );
    }

    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: body(_currentIndex),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        child: Visibility(
          visible: _show,
          child: Container(
            height: MediaQuery.of(context).size.height / 13,
            child: BottomNavigationBar(
              onTap: onTabTapped, // new
              currentIndex:
                  _currentIndex, // this will be set when a new tab is tapped
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: new Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.mail),
                  title: new Text('Messages'),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text('Profile'))
              ],
            ),
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
