/*
 * @Author: 首页
 * @Date: 2019-10-11 10:50:26
 * @LastEditTime: 2019-11-08 13:23:25
 * @LastEditors: Please set LastEditors
 * @Description: 修改
 * @FilePath: /flutter_deer/lib/home/page/home_page.dart
 */
import 'dart:core';
import 'dart:core' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/home/page/select_page.dart';
import 'package:flutter_deer/home/presenter/home_presenter.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
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
    num screenWidth = (MediaQuery.of(context).size.width - 60) / 2;
    List<Widget> list = [];
    if (content == null) return list;
    content.forEach((data) => {
          list.add(Column(children: <Widget>[
            MyTitle(
              text: "核心数据",
            ),
            Visibility(
              visible: noTab == 1,
              child: DataItem(
                title: "满期保费",
                percentage: "2.12",
                count: '${data['expire_cost']}',
              ),
            ),
            Wrap(
              // spacing: 19.0,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 19.0,
              //     childAspectRatio: 2),
              children: <Widget>[
                Container(
                  width: screenWidth,
                  child: DataItem(
                    title: "全部损失总金额",
                    percentage: "2.12",
                    count: '${data['all_lost']}',
                  ),
                ),
                Gaps.hGap16,
                Visibility(
                    visible: Constant.INSIDE_OUTSIDE == 0,
                    maintainSize: false,
                    child: Container(
                        width: screenWidth,
                        child: DataItem(
                          title: "英大财险赔款总额",
                          percentage: "2.12",
                          count: '${data['yinda_lost']}',
                        ))),
                Container(
                    width: screenWidth,
                    child: DataItem(
                      title: "案件数量",
                      percentage: "2.12",
                      count: '${data['case_num']}',
                    )),
                Visibility(
                    visible: Constant.INSIDE_OUTSIDE == 0,
                    maintainSize: false,
                    child: Gaps.hGap16),
                // Gaps.hGap16,
                Container(
                    width: screenWidth,
                    child: DataItem(
                      title: "案均赔款",
                      percentage: "-2.12",
                      count: '${data['avg_cost']}',
                    )),
                Visibility(
                    visible: Constant.INSIDE_OUTSIDE == 1,
                    maintainSize: false,
                    child: Gaps.hGap16),
                Visibility(
                  visible: noTab == 1,
                  maintainSize: false,
                  child: Container(
                      width: screenWidth,
                      child: DataItem(
                        title: "满期赔付率",
                        percentage: "2.12",
                        count: '${data['expire_pay_rate']}',
                      )),
                ),
                Visibility(
                  visible: noTab == 1 && Constant.INSIDE_OUTSIDE != 1,
                  maintainSize: false,
                  child: Gaps.hGap16,
                ),
                Container(
                    width: screenWidth,
                    child: DataItem(
                      title: "出险报案周期",
                      percentage: "-2.12",
                      count: '${data['case_call_period']}',
                    )),

                Visibility(
                  visible: noTab == 0 && Constant.INSIDE_OUTSIDE != 1 ||
                      noTab == 1 && Constant.INSIDE_OUTSIDE == 1,
                  maintainSize: false,
                  child: Gaps.hGap16,
                ),
                Container(
                    width: screenWidth,
                    child: DataItem(
                      title: "报案结案周期",
                      percentage: "2.12",
                      count: '${data['call_done_period']}',
                    )),
              ],
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
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CustomTab(
                  textList: ["已决", "全部"],
                  onTabChange: (index) async {
                    noTab = index;
                    presenter.getIndex(noTab,
                        province: province, city: city, county: county);
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Gaps.vGap16,
                  Text(
                    '英大财险风险地图看板(${Constant.INSIDE_OUTSIDE == 0 ? '内部' : "外部"}-${noTab == 0 ? '已决' : '全部'})',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 26, bottom: 10),
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
