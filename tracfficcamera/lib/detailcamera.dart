import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ListCamera extends StatefulWidget {
  @override
  _ListCameraState createState() => _ListCameraState();
}

class _ListCameraState extends State<ListCamera> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      MenuSearch(),
      DisplayNameCamera(),
    ]);
  }
}

class MenuSearch extends StatefulWidget {
  @override
  _MenuSearchState createState() => _MenuSearchState();
}

class _MenuSearchState extends State<MenuSearch> {
  final dsQuan = <Map<String, dynamic>>[
    {'TenQuan': 'Quận 1', 'Value': '1'},
    {'TenQuan': 'Quận 12', 'Value': '2'},
    {'TenQuan': 'Quận Thủ Đức', 'Value': '3'},
    {'TenQuan': 'Quận 9', 'Value': '12'},
    {'TenQuan': 'Quận Gò Vấp', 'Value': '4'},
    {'TenQuan': 'Quận Bình Thạnh', 'Value': '5'},
    {'TenQuan': 'Quận Tân Bình', 'Value': '6'},
    {'TenQuan': 'Quận Tân Phú', 'Value': '7'},
    {'TenQuan': 'Quận Phú Nhuận', 'Value': '8'},
    {'TenQuan': 'Quận 2', 'Value': '9'},
    {'TenQuan': 'Quận 3', 'Value': '10'},
    {'TenQuan': 'Quận 10', 'Value': '11'},
    {'TenQuan': 'Quận 11', 'Value': '24'},
    {'TenQuan': 'Quận 4', 'Value': '13'},
    {'TenQuan': 'Quận 5', 'Value': '14'},
    {'TenQuan': 'Quận 6', 'Value': '15'},
    {'TenQuan': 'Quận 8', 'Value': '16'},
    {'TenQuan': 'Quận Bình Tân', 'Value': '17'},
    {'TenQuan': 'Quận 7', 'Value': '18'},
    {'TenQuan': 'Huyện Củ Chi', 'Value': '19'},
    {'TenQuan': 'Huyện Hóc Môn', 'Value': '20'},
    {'TenQuan': 'Huyện Bình Chánh', 'Value': '21'},
    {'TenQuan': 'Huyện Nhà Bè', 'Value': '22'},
    {'TenQuan': 'Huyện Cần Giờ', 'Value': '23'},
  ];
  String _value;
  String test;
  void abac(String value) {
    //  if (value == "1") {
    setState(() {
      test = value + TimeOfDay.now().toString();
    });
    //  }
  }

  DropdownMenuItem<String> selectQuan(String tenQuan, String value) =>
      DropdownMenuItem(
        value: value,
        child: Text(
          tenQuan,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 23,
          ),
        ),
      );
  DropdownButton _itemDown() => DropdownButton<String>(
        hint: Text(
          "Chọn Khu Vực Muốn Xem Camera",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        items: [
          selectQuan(dsQuan[0]["TenQuan"], dsQuan[0]["Value"]),
          selectQuan(dsQuan[1]["TenQuan"], dsQuan[1]["Value"]),
          selectQuan(dsQuan[2]["TenQuan"], dsQuan[2]["Value"]),
          selectQuan(dsQuan[3]["TenQuan"], dsQuan[3]["Value"]),
          selectQuan(dsQuan[4]["TenQuan"], dsQuan[4]["Value"]),
          selectQuan(dsQuan[5]["TenQuan"], dsQuan[5]["Value"]),
          selectQuan(dsQuan[6]["TenQuan"], dsQuan[6]["Value"]),
          selectQuan(dsQuan[7]["TenQuan"], dsQuan[7]["Value"]),
          selectQuan(dsQuan[8]["TenQuan"], dsQuan[8]["Value"]),
          selectQuan(dsQuan[9]["TenQuan"], dsQuan[9]["Value"]),
          selectQuan(dsQuan[10]["TenQuan"], dsQuan[10]["Value"]),
          selectQuan(dsQuan[11]["TenQuan"], dsQuan[11]["Value"]),
          selectQuan(dsQuan[12]["TenQuan"], dsQuan[12]["Value"]),
          selectQuan(dsQuan[13]["TenQuan"], dsQuan[13]["Value"]),
          selectQuan(dsQuan[14]["TenQuan"], dsQuan[14]["Value"]),
          selectQuan(dsQuan[15]["TenQuan"], dsQuan[15]["Value"]),
          selectQuan(dsQuan[16]["TenQuan"], dsQuan[16]["Value"]),
          selectQuan(dsQuan[17]["TenQuan"], dsQuan[17]["Value"]),
          selectQuan(dsQuan[18]["TenQuan"], dsQuan[18]["Value"]),
          selectQuan(dsQuan[19]["TenQuan"], dsQuan[19]["Value"]),
          selectQuan(dsQuan[20]["TenQuan"], dsQuan[20]["Value"]),
          selectQuan(dsQuan[21]["TenQuan"], dsQuan[21]["Value"]),
          selectQuan(dsQuan[22]["TenQuan"], dsQuan[22]["Value"]),
          selectQuan(dsQuan[23]["TenQuan"], dsQuan[23]["Value"]),
        ],
        onChanged: (value) {
          abac(value);
          setState(() {
            _value = value;
          });
        },
        value: _value,
        isExpanded: true,
      );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WaveClipperOne(),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red, Colors.blue])),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Card(
                elevation: 20,
                margin: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: _itemDown(),
                )),
          ],
        ),
      ],
    );
  }
}

Widget card() {return Card(
      elevation: 15,
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      "http://giaothong.hochiminhcity.gov.vn/render/ImageHandler.ashx?id=56df8381c062921100c143e2",
                      filterQuality: FilterQuality.low,
                      // height: 70,
                      // width: 130,
                      scale: 5.8,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                    'Dien Bien Phu , Nguyen Huu Carnh (Tren Cau)',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(Icons.favorite),
                ],
              ),
            ),
          ),
        ],
      ),
    );}
class DisplayNameCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return card();
  }
}
