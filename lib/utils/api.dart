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

  Api.createHuman(String name, String image, String gender, String age, String figure)
    : super(
        '/MeetAgain-memoryBoxes/createMemoryBox',
        ReqMethod.post,
        parameters: {
          'boxName': name,
          'coverImage': image,
          'frontImage': image,
          'gender': gender,
          'ageStage': age,
          'bodyType': figure,
        },
        encoding: ReqEncoding.json,
      );
}
