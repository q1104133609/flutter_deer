import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailFormItem extends StatelessWidget {
  DetailFormItem({@required this.title, @required this.content}) : super();
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(content,
                style: TextStyle(color: Color(0xff8C9490), fontSize: 16))
          ],
        ));
  }
}
