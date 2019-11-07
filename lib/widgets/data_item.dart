import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

class DataItem extends StatelessWidget {
  const DataItem({
    @required this.title,
    @required this.count,
    @required this.percentage,
  }) : super();

  final String title;
  final String percentage;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(title,
                      style: TextStyle(color: Colours.app_main, fontSize: 15)),
                ),
                Container(
                  width: 48,
                  height: 20,
                  margin: EdgeInsets.only(left: 5),
                  alignment: Alignment.center,
                  child: Text(
                      (double.parse(percentage) > 0
                              ? "+$percentage"
                              : percentage) +
                          "%",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  decoration: new BoxDecoration(
                    color: double.parse(percentage) > 0
                        ? Color(0xff255BD1)
                        : Color(0xff239131),
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 8),
                alignment: Alignment.centerLeft,
                child: Text(count == 'null' ? '-' : count,
                    style: TextStyle(color: Colors.white, fontSize: 30))),
          ],
        ));
  }
}
