import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  //seleccio de diferents menus
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt{
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int index ) {
    this._selectedMenuOpt = index;
    notifyListeners();
  }
  
}