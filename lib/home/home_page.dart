import 'dart:convert';
import 'dart:core';
import 'dart:core' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
import 'package:flutter_deer/home/select_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/map_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/choose_city.dart';
import 'package:flutter_deer/widgets/comment_title.dart';
import 'package:flutter_deer/widgets/custom_tab.dart';
import 'package:flutter_deer/widgets/data_item.dart';
import 'package:flutter_deer/widgets/progress_item.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeProvider provider = HomeProvider();
  num noTab = 0;
  WebViewController _controller;
  String address = 'china';
  @override
  void initState() {
    super.initState();
  }

  DateTime _lastTime;

  Future<bool> _isExit() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      Toast.show("再次点击退出应用");
      return Future.value(false);
    }
    Toast.cancelToast();
    return Future.value(true);
  }

  Future<String> _getFile() async {
    return await rootBundle.loadString('assets/map/echart.html');
  }

  void setMapData(String address) {
    String mapJson = "";
    if (address == "china") {
      mapJson = address;
    } else if (Map.cityList.containsKey(address)) {
      mapJson = 'city/${Map.cityList[address]}';
    } else if (Map.provinceList.containsKey(address)) {
      mapJson = 'province/${Map.provinceList[address]}';
    }
    rootBundle.loadString('assets/map/$mapJson.json').then((value) {
      _controller
          .evaluateJavascript('setValue("$mapJson",$value)')
          .then((result) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
        builder: (_) => provider,
        child: WillPopScope(
            onWillPop: _isExit,
            child: Scaffold(
              appBar: MyAppBar(
                isBack: false,
                centerTitle: "英大财险风险地图",
              ),
              body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomTab(
                        margin: EdgeInsets.only(top: 10),
                        textList: ["已决", "全部"],
                        onTabChange: (index) {
                          setState(() {
                            noTab = index;
                          });
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 10),
                        color: Colours.material_bg,
                        child: FutureBuilder<String>(
                            future: _getFile(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return WebView(
                                  initialUrl: new Uri.dataFromString(
                                          snapshot.data,
                                          mimeType: 'text/html',
                                          encoding: Encoding.getByName('utf-8'))
                                      .toString(),
                                  javascriptMode: JavascriptMode.unrestricted,
                                  onWebViewCreated: (controller) {
                                    this._controller = controller;
                                  },
                                  onPageFinished: (url) {
                                    setMapData("china");
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            }),
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Expanded(
                          flex: 1,
                          child: ListView(
                            children: <Widget>[
                              ChooseCity(
                                chooseAddress: (address) {
                                  this.address = address;
                                  setMapData(address.replaceAll('省', ''));
                                },
                              ),
                              MaterialButton(
                                  minWidth: double.infinity,
                                  height: 44,
                                  color: Colours.app_main,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  textColor: Colors.white,
                                  child: Text("查询详情",
                                      style: TextStyle(fontSize: 17)),
                                  onPressed: () {
                                    AppNavigator.push(context, SelecePage(address: address));
                                  }),
                              getDataView(),
                              getProgressView()
                            ],
                          ))
                    ],
                  )),
            )));
  }

  Widget getProgressView() {
    return Column(children: <Widget>[
      MyTitle(
        text: "详细数据",
      ),
      ProgressItem(
        title: "案件总量排名",
        list: [{}, {}, {}, {}],
        bgColor: Color(0x3300E9FF),
        valueColor: Color(0xff00E9FF),
      ),
      ProgressItem(
        title: "案件总金额排名",
        list: [{}, {}, {}, {}],
        bgColor: Color(0x330979E8),
        valueColor: Color(0xff0979E8),
      )
    ]);
  }

  Widget getDataView() {
    return Column(children: <Widget>[
      MyTitle(
        text: "核心数据",
      ),
      DataItem(
        title: "满期保费",
        percentage: "2.12",
        count: "14223",
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: DataItem(
              title: "全部损失总金额",
              percentage: "2.12",
              count: "14223",
            ),
          ),
          Container(
            width: 19,
          ),
          Expanded(
            flex: 1,
            child: DataItem(
              title: "英大财险赔款总额",
              percentage: "2.12",
              count: "14223",
            ),
          )
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: DataItem(
              title: "案件数量",
              percentage: "2.12",
              count: "14223",
            ),
          ),
          Container(
            width: 19,
          ),
          Expanded(
            flex: 1,
            child: DataItem(
              title: "案均赔款",
              percentage: "-2.12",
              count: "14223",
            ),
          )
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: DataItem(
              title: "满期赔付率",
              percentage: "2.12",
              count: "14223",
            ),
          ),
          Container(
            width: 19,
          ),
          Expanded(
            flex: 1,
            child: DataItem(
              title: "出险报案周期",
              percentage: "-2.12",
              count: "14223",
            ),
          )
        ],
      ),
      DataItem(
        title: "报案结案周期",
        percentage: "2.12",
        count: "14223",
      ),
    ]);
  }
}
