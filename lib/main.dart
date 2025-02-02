import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/home/page/home_page.dart';
import 'package:flutter_deer/provider/theme_provider.dart';
import 'package:flutter_deer/routers/application.dart';
import 'package:flutter_deer/routers/routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() async {
//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
  await SpUtil.getInstance();
  runApp(MyApp());
  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  
  final Widget home;
  
  MyApp({this.home}) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ChangeNotifierProvider<ThemeProvider>(
        builder: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (_, provider, __) {
            return MaterialApp (
              title: '英大财险风险看板',
              // showPerformanceOverlay: true, //显示性能标签
              //debugShowCheckedModeBanner: false,
              theme: provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              home: Home(),
              onGenerateRoute: Application.router.generator,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('zh', 'CH'),
                Locale('en', 'US')
              ]
            );
          },
        ),
      ),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom
    );
  }
}
