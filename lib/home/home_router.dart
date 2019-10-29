import 'package:fluro/fluro.dart';
import 'package:flutter_deer/home/page/home_detail.dart';
import 'package:flutter_deer/home/page/select_page.dart';
import 'package:flutter_deer/routers/router_init.dart';

class HomeRouter implements IRouterProvider {
  static String selectPage = "/selectPage";
  static String homeDetail = "/homeDetail";
  @override
  void initRouter(Router router) {
    router.define(selectPage, handler: Handler(handlerFunc: (_, params) {
      return SelecePage(address: params['address'].first);
    }));
    router.define(homeDetail, handler: Handler(handlerFunc: (_, params) {
      return HomeDetailPage();
    }));
  }
}
