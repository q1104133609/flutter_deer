import 'package:flutter_deer/order/models/search_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "SearchEntity") {
      return SearchEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}