import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class Utils {
  static String generateSHA256Hash(String password){
    
    var bytes = utf8.encode(password); // data being hashed
    final passwordHash = sha256.convert(bytes).toString();

    return passwordHash;
  }
}