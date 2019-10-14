import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deer/util/city_enum.dart';
import 'package:flutter_deer/util/toast.dart';

class ChooseCity extends StatefulWidget {
  final Function(String) chooseAddress;

  ChooseCity({@required this.chooseAddress});
  @override
  _ChooseCity createState() => _ChooseCity();
}

class _ChooseCity extends State<ChooseCity> {
  Result pResult;
  Result cResult;
  Result aResult;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          getCityItem(CityEnum.P),
          line(),
          getCityItem(CityEnum.C),
          line(),
          getCityItem(CityEnum.A),
          line(),
        ],
      ),
    );
  }

  Widget getCityItem(CityEnum address) {
    return GestureDetector(
        onTap: () async {
          if (address == CityEnum.C && pResult == null) {
            Toast.show("请先选择省份");
            return;
          }
          if (address == CityEnum.A && cResult == null) {
            Toast.show("请先选择城市");
            return;
          }
          Result result = await CityPickers.showCityPicker(
              context: context,
              theme: ThemeData(hintColor: Colors.black),
              locationCode: address == CityEnum.C
                  ? pResult.provinceId
                  : address == CityEnum.A ? cResult.cityId : "110000",
              showType: address == CityEnum.C
                  ? ShowType.c
                  : address == CityEnum.P ? ShowType.p : ShowType.a);
          if (address == CityEnum.P) {
            setState(() {
              pResult = result;
              cResult = null;
              aResult = null;
            });
            widget.chooseAddress(pResult.provinceName);
          } else if (address == CityEnum.C) {
            setState(() {
              cResult = result;
              aResult = null;
            });
            widget.chooseAddress(cResult.cityName);
          } else {
            setState(() {
              aResult = result;
            });
            // widget.chooseAddress(aResult.areaName);
          }
        },
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 12),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                address == CityEnum.C ? '市' : address == CityEnum.P ? '省' : '县',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              Row(
                children: <Widget>[
                  Text(
                    address == CityEnum.C
                        ? (cResult != null ? cResult.cityName : "全部")
                        : address == CityEnum.P
                            ? (pResult != null ? pResult.provinceName : "全部")
                            : (aResult != null ? aResult.areaName : "全部"),
                    style: TextStyle(color: Color(0xffA7ACA9), fontSize: 17),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Image.asset("assets/images/img_down.png",
                        height: 8, width: 16),
                  )
                ],
              )
            ],
          ),
        ));
  }

  static Widget line() => Container(
        width: double.infinity,
        height: 1,
        margin: EdgeInsets.symmetric(vertical: 12),
        color: Color(0x33eeeeee),
      );
}
