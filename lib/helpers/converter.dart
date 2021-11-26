import 'dart:convert';

import 'package:crypto/crypto.dart';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

String moneyFormat(String price) {
  var value = '';
  String aRegexMoney = r'\D';
  String bRegexMoney = r'\B(?=(\d{3})+(?!\d))';

  if (price.length > 2) {
    value = price;
    value = value.replaceAll(RegExp(aRegexMoney), '');
    value = value.replaceAll(RegExp(bRegexMoney), ',');
  }
  return value;
}