import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({
    @required this.text,
  }) : super();

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.only(top: 30),
      child:Row(
      children: <Widget>[
        Container(
          width: 4,
          height: 13,
          margin: EdgeInsets.only(right: 6),
          decoration: new BoxDecoration(
            color: Colours.app_main,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        Text(text, style: TextStyle(color: Colours.app_main, fontSize: 17))
      ],
    ));
  }
}
