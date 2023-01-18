import 'package:flutter/material.dart';

import 'constants.dart';
import 'cupertino.dart';
import 'material.dart';

IconData? iconPicker(String name, String fontFamily) {
  switch (fontFamily) {
    case 'CupertinoIcons':
      return cupertinoIcons[name];
    default:
      return materialIcon[name];
  }
}

String iconPickerName(IconData icon) {
  Map<String, IconData> iconList;
  switch (icon.fontFamily) {
    case 'CupertinoIcons':
      iconList = cupertinoIcons;
      break;
    default:
      iconList = materialIcon;
      break;
  }
  for (final item in iconList.keys.toList()) {
    if (iconList[item]!.codePoint == icon.codePoint) {
      return item;
    }
  }
  return iconList.keys.first;
}

Map<String, IconData> getSelectedPack(IconPack? pickedPack) {
  switch (pickedPack) {
    case IconPack.cupertino:
      return cupertinoIcons;
    default:
      return materialIcon;
  }
}
