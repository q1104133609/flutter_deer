import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_progress_view.dart';

class ProgressItem extends StatelessWidget {
  const ProgressItem({
    @required this.title,
    @required this.list,
    this.bgColor,
    this.valueColor,
  }) : super();

  final String title;
  final List<Object> list;
  final Color bgColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: TextStyle(color: Colours.app_main, fontSize: 17)),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 4),
                child: Column(children: <Widget>[
                  ...getList(),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("查看全部",
                          style: TextStyle(color: Colors.white, fontSize: 17)))
                ])),
          ],
        ));
  }

  List<Widget> getList() {
    List<Widget> mylist = [];
    list.forEach((v) => {
          mylist.add(MyProgressView(
              title: "险类1",
              percentage: 50,
              count: "413",
              bgColor: bgColor,
              valueColor: valueColor))
        });
    return mylist;
  }
}
