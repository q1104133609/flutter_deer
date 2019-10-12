import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/colors.dart';

class MyProgressView extends StatelessWidget {
  const MyProgressView({
    @required this.title,
    @required this.count,
    @required this.percentage,
    this.bgColor,
    this.valueColor,
  }) : super();
  final String title;
  final String count;
  final num percentage;
  final Color bgColor;
  final Color valueColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colours.app_main, fontSize: 16)),
          Expanded(
              flex: 1,
              child: Container(
                height: 10,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: new BoxDecoration(
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
                child: new ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: LinearProgressIndicator(
                      value: percentage.toDouble() / 100,
                      backgroundColor: this.bgColor,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(this.valueColor),
                    )),
              )),
          Text(count, style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
