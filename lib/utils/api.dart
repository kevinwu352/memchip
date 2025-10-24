import '/network/network.dart';

final class Api extends Endpoint {
  Api.accountSendCode(String email)
    : super(
        '/emailAliyun/sendVerificationCodeToLogin',
        ReqMethod.post,
        parameters: {'email': email},
        encoding: ReqEncoding.json,
      );
  // Api.delete(int id) : super('/c/xxx', ReqMethod.get);
}
