
import 'package:dio/dio.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:test/test.dart';

void main(){
  
  group('dio_test', (){
    Dio dio;
    setUp((){
      /// 测试配置
      dio = DioUtils.instance.getDio();
      dio.options.baseUrl = "https://api.github.com/";
    });
    
   
  });
}