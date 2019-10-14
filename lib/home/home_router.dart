import 'package:fluro/fluro.dart';
import 'package:flutter_deer/home/select_page.dart';
import 'package:flutter_deer/routers/router_init.dart';

class HomeRouter implements IRouterProvider {
  static String selectPage = "/selectPage";
  @override
  void initRouter(Router router) {
    router.define(selectPage, handler: Handler(handlerFunc: (_, params) {
      print(params['address']);
      print(params['address'][0]);
      return SelecePage(address: '北京');
    }));
  }
}
