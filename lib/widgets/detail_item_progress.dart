import 'package:flutter/material.dart';
import 'package:flutter_deer/res/colors.dart';

import 'my_progress_view.dart';

class DetailItemProgress extends StatelessWidget {
  DetailItemProgress(
      {@required this.title,
      @required this.percentage,
      @required this.progressColor,
      @required this.count})
      : super();
  final String title;
  final String percentage;
  final String count;
  final Color progressColor;
  @override
  Widget build(BuildContext context) {
    var valueColor = progressColor.withAlpha(50);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            width: 200,
            child: Row(
              children: <Widget>[
                Expanded(
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
            )),
        MyProgressView(
            percentage: 50,
            count: count == 'null' ? '-' : count,
            bgColor: valueColor,
            top: 10,
            progressHorizontal: EdgeInsets.only(right: 50),
            valueColor: progressColor)
      ],
    );
  }
}
