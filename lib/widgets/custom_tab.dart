import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

class CustomTab extends StatefulWidget {
  final List<String> textList;
  final Function(num) onTabChange;
  final EdgeInsetsGeometry margin; 

  CustomTab({@required this.textList, @required this.onTabChange,this.margin});

  @override
  _CustomTab createState() => _CustomTab();
}

class _CustomTab extends State<CustomTab> {
  num nowCheck = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      width: double.parse((widget.textList.length * 49 + 2).toString()),
      decoration: new BoxDecoration(
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        //设置四周边框
        border: new Border.all(width: 1, color: Colours.app_main),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...getTabList()],
      ),
    );
  }

  List<Widget> getTabList() {
    List<Widget> list = [];
    for (var i = 0; i < widget.textList.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          setState(() => nowCheck = i);
          widget.onTabChange(i);
        },
        child: Container(
            height: 30,
            width: 49,
            alignment: Alignment.center,
            color: nowCheck == i ? Colours.app_main : Color(0x00000000),
            child: Text(widget.textList[i],
                style: TextStyle(
                  color: nowCheck == i ? Colors.white : Colours.app_main,
                  fontSize: 14,
                ))),
      ));
    }

    return list;
  }
}
