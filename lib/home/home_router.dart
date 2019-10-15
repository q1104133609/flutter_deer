import 'package:fluro/fluro.dart';
import 'package:flutter_deer/home/page/select_page.dart';
import 'package:flutter_deer/routers/router_init.dart';

class HomeRouter implements IRouterProvider {
  static String selectPage = "/selectPage";
  @override
  void initRouter(Router router) {
    router.define(selectPage, handler: Handler(handlerFunc: (_, params) {
      return SelecePage(address: params['address'].first);
    }));
  }
}
