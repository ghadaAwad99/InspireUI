import 'package:flutter/material.dart';

import 'logs.dart';

class HexColor extends Color {
  static int _getColorFromHex(dynamic hexColor) {
    try {
      if (hexColor is String) {
        hexColor = hexColor.toUpperCase().replaceAll('#', '');
        if (hexColor.length == 6) {
          hexColor = 'FF$hexColor';
        }

        if (hexColor.isNotEmpty) {
          return int.parse(hexColor, radix: 16);
        }
      }
      return int.parse('FFFFFFFF', radix: 16);
    } catch (e, trace) {
      printLog(e);
      printLog(trace);
      return int.parse('FFFFFFFF', radix: 16);
    }
  }

  HexColor(final hexColor) : super(_getColorFromHex(hexColor));

  // ignore: prefer_constructors_over_static_methods
  static HexColor fromJson(dynamic json) => HexColor(json);

  static List<HexColor>? fromListJson(List listJson) {
    try {
      final listColor = listJson.map((e) {
        // ignore: avoid_as
        return HexColor.fromJson(e as String);
        // ignore: avoid_as
      }).toList();

      // ignore: avoid_as
      return listColor;
    } catch (e, trace) {
      printLog(e);
      printLog(trace);
      return [];
    }
  }

  String toJson() => super.value.toRadixString(16);
}
