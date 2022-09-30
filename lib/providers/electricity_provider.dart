import 'package:flutter/material.dart';

import '../models/main_service.dart';

class Electricity with ChangeNotifier {
  List<MainServiceModel> _electricityDistributions = [];

  List<MainServiceModel> get electricityDistributions {
    return _electricityDistributions;
  }

  set setElectricityDistributions(
      List<MainServiceModel> electricityDistributions) {
    _electricityDistributions = electricityDistributions;
  }
}
