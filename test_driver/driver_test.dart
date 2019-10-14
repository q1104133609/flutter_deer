
import 'home/splash_page_test.dart' as splash_test;
import 'login/login_page_test.dart' as login_test;
import 'order/order_test.dart' as order_test;
import 'statistic/statistic_test.dart' as statistic_test;
import 'account/account_test.dart' as account_test;
import 'goods/goods_test.dart' as goods_test;

/// 各模块统一运行，也可单独执行子模块测试
void main() {
  splash_test.main();
  login_test.main();
  order_test.main();
  goods_test.main();
  statistic_test.main();
  account_test.main();
}