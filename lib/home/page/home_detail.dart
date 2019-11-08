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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      presenter.mobileTerminalQuery(widget.selectModel);
    });
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
                  ...getDataView(provider.data['detail']),
                  MyTitle(
                    text: "详细数据",
                  ),
                  ...getItemView(provider.data['core']),
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
  HomeDetailProvider createProvider() => HomeDetailProvider();

  List<Widget> getDataView(data) {
    if (data == null) return [];
    List<Widget> list = [];
    data.forEach((v) => list.add(Column(children: <Widget>[
          MyTitle(
            text: "核心数据",
          ),
          DataItem(
            title: "满期保费",
            percentage: "2.12",
            count: '${v['expire_cost']}',
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: DataItem(
                  title: "全部损失总金额",
                  percentage: "2.12",
                  count: '${v['expire_cost']}',
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
                  count: '${v['yinda_lost']}',
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
                  count: '${v['case_num']}',
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
                  count: '${v['avg_cost']}',
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
                  count: '${v['expire_pay_rate']}',
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
                  count: '${v['case_call_period']}',
                ),
              )
            ],
          ),
          DataItem(
            title: "报案结案周期",
            percentage: "2.12",
            count: '${v['call_done_period']}',
          ),
        ])));
    return list;
  }

  List<Widget> getItemView(data) {
    if (data == null) return [];
    List<Widget> list = [];
    data.forEach((v) => list.add(DetailDataItem(v)));
    return list;
  }
}
