import 'package:flutter/foundation.dart';
import 'package:topitup/models/sub_service.dart';

class TvCable with ChangeNotifier {
  List<SubServiceModel> _tvCables = [];

  List<SubServiceModel> get tvCables {
    return _tvCables;
  }

  set setTvCables(List<SubServiceModel> tvCables) {
    _tvCables = tvCables;
  }
}
