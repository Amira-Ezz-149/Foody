import 'package:flutter/material.dart';

class HeightProvider extends ChangeNotifier {
  HeightProvider(this.height);

  double height;

  void setHeight(context, num) {
    height = MediaQuery.of(context).size.height * 80 / 100 + num;
    print(height);

    notifyListeners();
  }
}
