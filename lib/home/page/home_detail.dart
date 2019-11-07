import 'package:flutter/material.dart';
import 'package:flutter_deer/home/models/select_model.dart';
import 'package:flutter_deer/home/presenter/home_detial_presenter.dart';
import 'package:flutter_deer/home/provider/home_detail_provider.dart';
import 'package:flutter_deer/mvp/base_page_state.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/comment_title.dart';
import 'package:flutter_deer/widgets/data_item.dart';
import 'package:flutter_deer/widgets/detail_data_form.dart';
import 'package:flutter_deer/widgets/detail_data_item.dart';
import 'package:flutter_deer/widgets/map_view.dart';

class HomeDetailPage extends StatefulWidget {
  HomeDetailPage({this.selectModel});
  final SelectModel selectModel;
  @override
  HomeDetailState createState() => HomeDetailState();
}

class HomeDetailState extends BasePageState<HomeDetailPage, HomeDetailPresenter,
    HomeDetailProvider> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  List<Widget> getItemView() {
    var i = List(10);
    return i.map((v) => DetailDataItem()).toList();
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

  @override
  HomeDetailPresenter createPresenter() {
    return HomeDetailPresenter();
  }

  @override
  Widget bindProvide(BuildContext key, provider, Widget child) {
    return Scaffold(
        appBar: MyAppBar(centerTitle: '内部-全部-非保单'),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              color: Colours.material_bg,
              child: MapView(),
              height: 200.0,
              width: double.infinity,
            ),
            Expanded(
              flex: 1,
              child: ListView(
                children: <Widget>[
                  getDataView(),
                  MyTitle(
                    text: "详细数据",
                  ),
                  ...getItemView(),
                  DetailDataFrom(),
                  Gaps.vGap16,
                  DetailDataFrom(),
                ],
              ),
            ),
          ]),
        ));
  }

  @override
  createProvider() => HomeDetailProvider();
}
