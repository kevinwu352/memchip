import '/network/network.dart';

final class Api extends Endpoint {
  Api.accountSendCode(String email)
    : super(
        '/emailAliyun/sendVerificationCodeToLogin',
        ReqMethod.post,
        parameters: {'email': email},
        encoding: ReqEncoding.json,
      );

  Api.accountCheckCode(String email, String code)
    : super(
        '/MeetAgain-user/emailLogin',
        ReqMethod.post,
        parameters: {'email': email, 'code': code},
        encoding: ReqEncoding.json,
      );

  Api.createGetUploadParas(String name)
    : super('/http/ext-storage-co/getUploadFileOptions', ReqMethod.get, parameters: {'cloudPath': name});
}
