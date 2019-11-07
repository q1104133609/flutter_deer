import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/resources.dart';

class CommentItem extends StatefulWidget {
  CommentItem(
      {this.onChooseTime,
      @required this.title,
      this.onChooseList,
      this.values,
      this.onInputChange,
      @required this.hint,
      this.isInput = false,
      this.showLine = true})
      : super();
  final Function onChooseTime;
  final Function onChooseList;
  final Function(String) onInputChange;
  final List<String> values;
  final String title;
  final bool showLine;
  final String hint;
  final bool isInput;
  @override
  CommentItemState createState() => CommentItemState();
}

class CommentItemState extends State<CommentItem> {
  var chooseCount = 0;
  var showText = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (widget.onChooseTime != null) {
              showTimePicker();
            } else if (widget.onChooseList != null) {
              showBottomPicker();
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                (widget.isInput
                    ? Expanded(
                        flex: 1,
                        child: TextField(
                            textAlign: TextAlign.right,
                            maxLength: 30,
                            autofocus: false,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            // controller: widget.controller,
                            onChanged: widget.onInputChange,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: widget.hint,
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                                counterText: "")))
                    : Text(showText.isNotEmpty ? showText : widget.hint,
                        style: TextStyle(
                            color: showText.isNotEmpty
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 16))),
              ],
            ),
          ),
        ),
        Visibility(
            visible: widget.showLine,
            child: Container(
              width: double.infinity,
              height: 1,
              color: Color(0x33EBEBEB),
            )),
      ],
    );
  }

  void showBottomPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 270,
              width: double.infinity,
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      bottomText(
                          child: Text('取消', style: TextStyles.textDarkGray16)),
                      Text('请选择', style: TextStyles.textSize16),
                      bottomText(
                          child: Text('确定', style: TextStyles.textNoaml16),
                          isOk: true),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    height: 220,
                    child: CupertinoPicker(
                        backgroundColor: Colors.white,
                        itemExtent: 30.0,
                        onSelectedItemChanged: (int value) {
                          setState(() {
                            chooseCount = value;
                          });
                        },
                        children: widget.values != null
                            ? widget.values.map((v) {
                                return new Text(v,
                                    style: TextStyles.textDarkGray16);
                              }).toList()
                            : [Text("")]))
              ]));
        });
  }

  Widget bottomText({Widget child, isOk = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showText = widget.values[chooseCount];
        });
        if (isOk) {
          widget.onChooseList(widget.values[chooseCount]);
        }
        Navigator.of(context).pop();
      },
      child: child,
    );
  }

  /*
   * 时间选择器 
   */
  void showTimePicker() {
    DatePicker.showDatePicker(context, showTitleActions: true,
        onConfirm: (date) {
      // print(DateUtils.apiDayFormat(date));
      setState(() {
        showText = "${date.year}年${date.month}月${date.day}日";
      });
      widget.onChooseTime(date.toString().split(" ")[0]);
    },
        currentTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        locale: LocaleType.zh,
        theme: DatePickerTheme(
            doneStyle: TextStyle(color: Colours.app_main, fontSize: 16)));
  }
}
