import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deer/home/models/select_model.dart';
import 'package:flutter_deer/home/page/home_detail.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/custom_tab.dart';
import 'package:flutter_deer/widgets/item_time_picker.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

/*
 * 查询条件页面
 */
class SelecePage extends StatefulWidget {
  SelecePage({this.address, this.province, this.city, this.county}) : super();
  final String address;
  final String province;
  final String city;
  final String county;
  @override
  SelecePageState createState() => SelecePageState();
}

class SelecePageState extends State<SelecePage> {
  SelectModel selectModel = SelectModel();
  int checkTab = 0;
  @override
  void initState() {
    super.initState();
    selectModel.province = widget.province;
    selectModel.address = widget.address;
    selectModel.city = widget.city;
    selectModel.county = widget.county;
    selectModel.type = '已决';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(centerTitle: '查询条件'),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              CustomTab(
                margin: EdgeInsets.only(top: 0, bottom: 16),
                textList: ['已决', '全部'],
                onTabChange: (index) {
                  selectModel.type = index == 0 ? '已决' : '已决未决';
                  setState(() {
                    checkTab = index;
                  });
                },
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 14,
                          width: 11,
                          child: SvgPicture.asset(
                            'assets/img_map.svg',
                            color: Colours.app_main,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(widget.address,
                              style: TextStyles.textNoaml16),
                        )
                      ],
                    ),
                    CommentItem(
                        title: '保单号',
                        hint: '填写保单号',
                        isInput: true,
                        onInputChange: (v) => selectModel.policyNo = v),
                    CommentItem(
                        title: '起保日期',
                        hint: '日期选择',
                        onChooseTime: (date) => selectModel.startDate = date),
                    CommentItem(
                        title: '终保日期',
                        hint: '日期选择',
                        onChooseTime: (date) => selectModel.endDate = date),
                    Visibility(
                      visible: checkTab == 0,
                      child: Column(
                        children: <Widget>[
                          CommentItem(
                              title: '联共保问题',
                              hint: '请选择',
                              onChooseList: (value) {},
                              values: ['选择一', '选择2']),
                          CommentItem(
                              title: '业务标识',
                              hint: '请选择',
                              onChooseList: (value) {},
                              values: ['选择一', '选择2']),
                          CommentItem(
                              title: '险类',
                              hint: '请选择',
                              onChooseList: (value) {},
                              values: ['选择一', '选择2']),
                        ],
                      ),
                    ),
                    CommentItem(
                        title: '险种',
                        hint: '请选择',
                        onChooseList: (value) {},
                        values: ['选择一', '选择2']),
                    CommentItem(
                        title: '出险日期',
                        hint: '日期选择',
                        onChooseTime: (date) => selectModel.damageTime = date),
                    CommentItem(
                        title: '报案日期',
                        hint: '日期选择',
                        onChooseTime: (date) =>
                            selectModel.reportStartTime = date),
                    Visibility(
                      visible: checkTab == 0,
                      child: Column(
                        children: <Widget>[
                          CommentItem(
                              title: '结案日期',
                              hint: '日期选择',
                              onChooseTime: (date) =>
                                  selectModel.endCaseTime = date),
                          CommentItem(
                              title: '案件状态',
                              hint: '请选择',
                              onChooseList: (value) {},
                              values: ['选择一', '选择2']),
                        ],
                      ),
                    ),
                    CommentItem(
                        title: '出险原因',
                        hint: '请选择',
                        onChooseList: (value) {},
                        values: ['选择一', '选择2']),
                    CommentItem(
                        title: '受损标的',
                        hint: '请选择',
                        onChooseList: (value) {},
                        showLine: false,
                        values: ['选择一', '选择2']),
                    Gaps.vGap16,
                    Gaps.vGap16,
                    MyButton(
                      text: '查询详情',
                      onPressed: () {
                        AppNavigator.push(
                            context, HomeDetailPage(selectModel: selectModel));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
