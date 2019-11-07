import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/colors.dart';

class MyProgressView extends StatelessWidget {
  const MyProgressView(
      {this.title,
      @required this.count,
      @required this.percentage,
      this.bgColor,
      this.valueColor,
      this.progressHorizontal,
      this.top})
      : super();
  final String title;
  final String count;
  final double percentage;
  final Color bgColor;
  final Color valueColor;
  final double top;
  final EdgeInsets progressHorizontal;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top == null ? 16 : top),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: title != null && title.isNotEmpty,
            child: Text(title ?? "",
                style: TextStyle(color: Colours.app_main, fontSize: 16)),
          ),
          Expanded(
              flex: 1,
              child: Container(
                height: 10,
                width: double.infinity,
                padding: progressHorizontal == null
                    ? EdgeInsets.symmetric(horizontal: 16)
                    : progressHorizontal,
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
          Container(
              width: 70,
              alignment: Alignment.centerRight,
              child: Text(count,
                  style: TextStyle(color: Colors.white, fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis,))
        ],
      ),
    );
  }
}
