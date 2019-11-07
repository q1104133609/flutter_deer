import 'package:flutter/material.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/progress_dialog.dart';
import 'package:provider/provider.dart';

import 'base_page_presenter.dart';
import 'mvps.dart';

abstract class BasePageState<
    T extends StatefulWidget,
    V extends BasePagePresenter,
    K extends ChangeNotifier> extends State<T> implements IMvpView {
  V presenter;
  K provider;

  BasePageState() {
    presenter = createPresenter();
    presenter.view = this;
    provider = createProvider();
  }
  K createProvider();
  V createPresenter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<K>(
        builder: (_) => provider,
        child: Consumer<K>(builder: (key, provider, child) {
          return bindProvide(key, provider, child);
        }));
  }

  Widget bindProvide(BuildContext key, K provider, Widget child);

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
    }
  }

  bool _isShowDialog = false;

  @override
  void showProgress() {
    /// 避免重复弹出
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showTransparentDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return WillPopScope(
                onWillPop: () async {
                  // 拦截到返回键，证明dialog被手动关闭
                  _isShowDialog = false;
                  return Future.value(true);
                },
                child: const ProgressDialog(hintText: "正在加载..."),
              );
            });
      } catch (e) {
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
  }

  @override
  void showToast(String string) {
    Toast.show(string);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    presenter?.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    presenter?.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    presenter?.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    presenter?.initState();
  }

  void didUpdateWidgets<W>(W oldWidget) {
    presenter?.didUpdateWidgets<W>(oldWidget);
  }
}
