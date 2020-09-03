import 'package:flutter/material.dart';

final countriesCode = ['eg', 'ae', 'us', 'fr', 'de'];
final countries = {
  'eg': 'Egypt',
  'ae': 'U.A.E',
  'us': 'U.S.A',
  'fr': 'France',
  'de': 'Germany',
};

class Country extends ChangeNotifier {
  String _countryCode = 'eg';
  String get countryCode => _countryCode;

  changeCode(String newCode) {
    _countryCode = newCode;
    notifyListeners();
  }
}
