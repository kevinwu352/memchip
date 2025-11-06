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

  Api.getAllChips() : super('/MeetAgain-memoryBoxes/getMemoryBoxesByUserId', ReqMethod.get);

  Api.createHuman(String name, String? image, String? gender, String? age, String? figure)
    : super(
        '/MeetAgain-memoryBoxes/createMemoryBox',
        ReqMethod.post,
        parameters: {
          'boxName': name,
          'coverImage': ?image,
          'frontImage': ?image,
          'gender': ?gender,
          'ageStage': ?age,
          'bodyType': ?figure,
        },
        encoding: ReqEncoding.json,
      );

  Api.createPet(
    String name,
    String? image1,
    String? image2,
    String? gender,
    String? species,
    bool? tail,
    String? personality,
  ) : super(
        '/pet/create',
        ReqMethod.post,
        parameters: {
          'name': name,
          'photos': [?image1, ?image2],
          'gender': ?gender,
          'species': ?species,
          'tail': ?tail,
          'character': [?personality],
        },
        encoding: ReqEncoding.json,
      );
}
