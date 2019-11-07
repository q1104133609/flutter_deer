/*
 * @Author: 首页
 * @Date: 2019-10-11 10:50:26
 * @LastEditTime: 2019-11-07 16:11:57
 * @LastEditors: Please set LastEditors
 * @Description: 修改
 * @FilePath: /flutter_deer/lib/home/page/home_page.dart
 */
import 'dart:core';
import 'dart:core' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_deer/home/presenter/home_presenter.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
import 'package:flutter_deer/home/page/select_page.dart';
import 'package:flutter_deer/mvp/base_page_state.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/app_navigator.dart';

import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/choose_city.dart';
import 'package:flutter_deer/widgets/comment_title.dart';
import 'package:flutter_deer/widgets/custom_tab.dart';
import 'package:flutter_deer/widgets/data_item.dart';
import 'package:flutter_deer/widgets/map_view.dart';
import 'package:flutter_deer/widgets/progress_item.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends BasePageState<Home, HomePresneter, HomeProvider> {
  num noTab = 0;
  String address = 'china';
  String province = '';
  String city = '';
  String county = '';
  DateTime _lastTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      presenter.getIndex(noTab);
    });
  }

  Widget getProgressView(data) {
    return Column(children: <Widget>[
      MyTitle(
        text: "详细数据",
      ),
      ProgressItem(
        title: "案件总量排名",
        list: data['caseNumRanking'] ?? [],
        bgColor: Color(0x3300E9FF),
        valueColor: Color(0xff00E9FF),
      ),
      ProgressItem(
        title: "案件总金额排名",
        list: data['amountRanking'] ?? [],
        bgColor: Color(0x330979E8),
        valueColor: Color(0xff0979E8),
      )
    ]);
  }

  List<Widget> getDataView(content) {
    List<Widget> list = [];
    if (content == null) return list;
    content.forEach((data) => {
          list.add(Column(children: <Widget>[
            MyTitle(
              text: "核心数据",
            ),
            DataItem(
              title: "满期保费",
              percentage: "2.12",
              count: '${data['expire_cost']}',
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: DataItem(
                    title: "全部损失总金额",
                    percentage: "2.12",
                    count: '${data['all_lost']}',
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
                    count: '${data['yinda_lost']}',
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
                    count: '${data['case_num']}',
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
                    count: '${data['avg_cost']}',
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
                    count: '${data['expire_pay_rate']}',
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
                    count: '${data['case_call_period']}',
                  ),
                )
              ],
            ),
            DataItem(
              title: "报案结案周期",
              percentage: "2.12",
              count: '${data['call_done_period']}',
            ),
          ]))
        });
    return list;
  }

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

  @override
  Widget bindProvide(BuildContext key, HomeProvider provider, Widget child) {
    return WillPopScope(
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
                    onTabChange: (index) async {
                      noTab = index;
                      presenter.getIndex(noTab,
                          province: province, city: city, county: county);
                      setState(() {});
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    color: Colours.material_bg,
                    child: MapView(address: address),
                    height: 200.0,
                    width: double.infinity,
                  ),
                  Expanded(
                      flex: 1,
                      child: ListView(
                        children: <Widget>[
                          ChooseCity(
                            chooseAddress: (chooseAddress, backProvince,
                                backCity, backCounty) async {
                              address = chooseAddress;
                              city = backCity;
                              province = backProvince;
                              county = backCounty;
                              await presenter.getIndex(noTab,
                                  province: province,
                                  city: city,
                                  county: county);
                              if (county.isEmpty) {
                                setState(() {});
                              }
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
                              child:
                                  Text("查询详情", style: TextStyle(fontSize: 17)),
                              onPressed: () {
                                AppNavigator.push(
                                    context,
                                    SelecePage(
                                        address: address,
                                        province: province,
                                        city: city,
                                        county: county));
                              }),
                          ...getDataView(provider.data['core']),
                          getProgressView(provider.data)
                        ],
                      ))
                ],
              )),
        ));
  }

  @override
  HomeProvider createProvider() => HomeProvider();

  @override
  HomePresneter createPresenter() => HomePresneter();
}
