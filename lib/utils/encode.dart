import 'dart:convert' as convert;

import 'package:encrypt/encrypt.dart' as encryptor;

/// For Google Play Services check to prevent app crashing.
mixin EncodeUtils {
  static String encodeCookie(String cookie) {
    final bytes = convert.utf8.encode(cookie);
    final base64Str = convert.base64.encode(bytes);
    return base64Str;
  }

  static String encodeData(String data) {
    final base64 = encodeCookie(data);
    final key = encryptor.Key.fromLength(32);
    final iv = encryptor.IV.fromLength(16);
    final encrypter = encryptor.Encrypter(encryptor.AES(key));
    final encrypted = encrypter.encrypt(base64, iv: iv);
    return encrypted.base64;
  }

  static String decodeUserData(String data) {
    final key = encryptor.Key.fromLength(32);
    final iv = encryptor.IV.fromLength(16);
    final encrypter = encryptor.Encrypter(encryptor.AES(key));
    final decrypted = encrypter.decrypt64(data, iv: iv);
    final base64Str = convert.base64.decode(decrypted);
    final result = convert.utf8.decode(base64Str);
    return result;
  }

  static String encode(String data) {
    final stringToBase64 = convert.utf8.fuse(convert.base64);
    final encrypted = stringToBase64.encode(data);
    return encrypted;
  }

  static String decode(String encodeString) {
    final stringToBase64 = convert.utf8.fuse(convert.base64);
    return stringToBase64.decode(encodeString);
  }
}
