
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/utils.dart';

class MyButton extends StatelessWidget {

  const MyButton({
    Key key,
    this.text: "",
    @required this.onPressed,
  }): super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    bool isDark = Utils.isDark(context);
    return FlatButton(
      onPressed: onPressed,
      textColor: isDark ? Colours.dark_button_text : Colors.white,
      color: isDark ? Colours.dark_app_main : Colours.app_main,
      disabledTextColor: isDark ? Colours.dark_text_disabled : Colours.text_disabled,
      disabledColor: isDark ? Colours.dark_button_disabled : Colours.button_disabled,
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: <Widget>[
          Container(
            height: 48,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(text, style: TextStyle(fontSize: Dimens.font_sp18),),
          ),
        ],
      ),
    );
  }
}
