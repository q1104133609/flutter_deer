import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/utils.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key key,
      this.backgroundColor,
      this.title: "",
      this.centerTitle: "",
      this.body,
      this.actionName: "",
      this.backImg: "assets/images/ic_back_black.png",
      this.onPressed,
      this.isBack: true})
      : super(key: key);

  final Color backgroundColor;
  final Widget body;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = Utils.getBackgroundColor(context);
    } else {
      _backgroundColor = backgroundColor;
    }

    SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: body != null
              ? body
              : Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: centerTitle.isEmpty
                              ? Alignment.centerLeft
                              : Alignment.center,
                          width: double.infinity,
                          child: Text(title.isEmpty ? centerTitle : title,
                              style: TextStyle(
                                fontSize: Dimens.font_sp18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                          padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        )
                      ],
                    ),
                    isBack
                        ? IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Navigator.maybePop(context);
                            },
                            tooltip: 'Back',
                            padding: const EdgeInsets.all(12.0),
                            icon: Image.asset(
                              backImg,
                              color: _overlayStyle == SystemUiOverlayStyle.light
                                  ? Colours.dark_text
                                  : Colours.text,
                            ),
                          )
                        : Gaps.empty,
                    Positioned(
                      right: 0.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            buttonTheme: ButtonThemeData(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          minWidth: 60.0,
                        )),
                        child: actionName.isEmpty
                            ? Container()
                            : FlatButton(
                                child: Text(actionName,
                                    key: const Key('actionName')),
                                textColor:
                                    _overlayStyle == SystemUiOverlayStyle.light
                                        ? Colours.dark_text
                                        : Colours.text,
                                highlightColor: Colors.transparent,
                                onPressed: onPressed,
                              ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
