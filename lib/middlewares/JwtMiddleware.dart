import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:todo/todo.dart';
import 'package:todo/utils/Utils.dart';

class JwtMiddleware extends Controller {
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

      final userId = decClaimSet.toJson()["sub"];

      if (userId == null) {
        throw JwtException;
      }

      print(userId);
      print(decClaimSet.expiry);
      //buscar no banco os dados do usuario e colocar no request

    } on JwtException {
      return Response.unauthorized();
    }

    return request;
  }
}
