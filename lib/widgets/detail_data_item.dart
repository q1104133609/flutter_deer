import 'package:flutter/material.dart';
import 'package:flutter_deer/res/colors.dart';

import 'detail_item_progress.dart';

class DetailDataItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: new Border.all(width: 1, color: Colours.app_main),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("险类1-险种1",
              style: TextStyle(color: Colours.app_main, fontSize: 17)),
          DetailItemProgress(
              title: "案件总量",
              percentage: "2.12",
              progressColor: Color(0xff00E9FF)),
          DetailItemProgress(
              title: "全部损失总金额",
              percentage: "-2.12",
              progressColor: Color(0xff0979E8)),
          DetailItemProgress(
              title: "英大财险赔款总额",
              percentage: "-2.12",
              progressColor: Color(0xff5A11D0)),
          DetailItemProgress(
              title: "案均赔款",
              percentage: "2.12",
              progressColor: Color(0xff1116D0)),
        ],
      ),
    );
  }
}
