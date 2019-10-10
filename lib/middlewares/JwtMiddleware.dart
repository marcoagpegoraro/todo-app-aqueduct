import 'dart:ffi';
import 'dart:js';

import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:todo/models/User.dart';
import 'package:todo/todo.dart';
import 'package:todo/utils/Utils.dart';

class JwtMiddleware extends Controller {
  JwtMiddleware(this.context);

  final ManagedContext context;

  @override
  FutureOr<RequestOrResponse> handle(Request request) {
    final authHeader = request.raw.headers["authorization"];

    if (authHeader.isEmpty) return Response.unauthorized();

    final authHeaderContent = authHeader[0].split(" ");
    if (authHeaderContent.length != 2 || authHeaderContent[0] != "Bearer")
      return Response.badRequest();

    String jwtToken = authHeaderContent[1];

    try {
      final JwtClaim decClaimSet =
          verifyJwtHS256Signature(jwtToken, Utils.jwtKey);

      final userId = decClaimSet.toJson()["sub"] as int;

      if (userId == null) {
        throw JwtException;
      }

      //verificar se o jwt está expirado

      print(userId);
      print(decClaimSet.expiry);

      final query = Query<User>(context)
        ..where((user) => user.id).equalTo(userId);
      final user = query.fetch();

      if (user == null) return Response.unauthorized();

      request.addResponseModifier((response) {
        response.headers['X-User-id'] = userId;
      });
    } on JwtException {
      return Response.unauthorized();
    }

    return request;
  }
}
