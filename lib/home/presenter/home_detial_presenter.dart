import 'package:flutter_deer/home/models/select_model.dart';
import 'package:flutter_deer/home/page/home_detail.dart';
import 'package:flutter_deer/mvp/base_page_presenter.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/http_api.dart';

class HomeDetailPresenter extends BasePagePresenter<HomeDetailState> {
  mobileTerminalQuery(SelectModel seach) async {
    asyncRequestNetwork<Map<dynamic, dynamic>>(Method.post,
        url: HttpApi.mobileTerminalQuery,
        isShow: true,
        params:  seach.toJson(), onSuccess: (content) {
      if (content != null) {
        view.provider.setData(content);
      }
    });
  }
}
