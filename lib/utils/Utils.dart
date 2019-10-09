import 'package:crypto/crypto.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'dart:convert';

import 'package:todo/models/User.dart'; // for the utf8.encode method

class Utils {
  static String generateSHA256Hash(String password) {
    var bytes = utf8.encode(password); // data being hashed
    final passwordHash = sha256.convert(bytes).toString();

    return passwordHash;
  }

  static String generateJWT(User user) {
    const key =
        "37f9ae83ea99a6e9ee9ee27a4364022c8caa1dddd5b1798b8b0eba9aab1f1dce";
    final claimSet = JwtClaim(
        subject: user.id.toString(),
        audience: <String>['audience1.example.com', 'audience2.example.com'],
        otherClaims: <String, dynamic>{
          'name': user.name,
          'email': user.email,
        },
        maxAge: const Duration(minutes: 5));

    final token = issueJwtHS256(claimSet, key);
    return token;
  }
}
