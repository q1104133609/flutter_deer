import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_deer/util/map_utils.dart';

class MapView extends StatefulWidget {
  MapView({this.address = 'china'}) : super();
  final String address;
  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  WebViewController _controller;
  Future<String> _getFile() async {
    return await rootBundle.loadString('assets/map/echart.html');
  }

  @override
  void didUpdateWidget(MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.address != widget.address) {
      setMapData(widget.address.replaceAll('省', ''));
    }
  }

  void setMapData(String address) {
    String mapJson = '';
    if (address == 'china' || address == '全国') {
      mapJson = 'china';
    } else if (Map.cityList.containsKey(address)) {
      mapJson = 'city/${Map.cityList[address]}';
    } else if (Map.provinceList.containsKey(address)) {
      mapJson = 'province/${Map.provinceList[address]}';
    }
    rootBundle.loadString('assets/map/$mapJson.json').then((value) {
      _controller
          .evaluateJavascript("setValue('$mapJson',$value)")
          .then((result) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _getFile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebView(
              initialUrl: new Uri.dataFromString(snapshot.data,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'))
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                this._controller = controller;
              },
              onPageFinished: (url) {
                setMapData(widget.address);
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        });
  }
}
