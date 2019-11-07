import 'dart:collection';

import 'package:flutter_deer/home/page/home_page.dart';
import 'package:flutter_deer/mvp/base_page_presenter.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/net.dart';

class HomePresneter extends BasePagePresenter<HomeState> {
  getIndex(num noTab) async {
    HashMap<String, dynamic> params = HashMap();
    params['type'] = noTab == 0 ? '已决' : '已决未决';
    asyncRequestNetwork<Map<dynamic, dynamic>>(Method.post,
        url: HttpApi.mobileTerminalIndex,
        isShow: true,
        params: params, onSuccess: (content) {
      if (content != null) {
        view.provider.setData(content);
      }
    });
  }
}
