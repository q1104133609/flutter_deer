import 'package:flutter/material.dart';
import 'package:flutter_deer/widgets/detail_form_item.dart';

class DetailDataFrom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DetailFormItem(
          title: "出险地址",
          content: "北京市昌平区XX路",
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Color(0x33EBEBEB),
        ),
        DetailFormItem(
          title: "资产所属单位",
          content: "北京市昌平区XX路",
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Color(0x33EBEBEB),
        ),
        DetailFormItem(
          title: "省",
          content: "北京市昌平区XX路",
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Color(0x33EBEBEB),
        ),
        DetailFormItem(
          title: "市",
          content: "北京市昌平区XX路",
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Color(0x33EBEBEB),
        ),
        DetailFormItem(
          title: "区",
          content: "北京市昌平区XX路",
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Color(0x33EBEBEB),
        )
      ],
    );
  }
}
