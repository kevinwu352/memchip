import '/network/network.dart';

final class Api extends Endpoint {
  Api.accountRegister(String account, String password)
    : super(
        '/user/register',
        ReqMethod.post,
        parameters: {'account': account, 'password': password},
        encoding: ReqEncoding.json,
      );

  Api.accountLogin(String account, String password)
    : super(
        '/user/passwordLogin',
        ReqMethod.post,
        parameters: {'account': account, 'password': password},
        encoding: ReqEncoding.json,
      );

  Api.accountSendCode(String account)
    : super('/user/sendVerificationCode', ReqMethod.post, parameters: {'account': account}, encoding: ReqEncoding.json);

  Api.accountCheckCode(String account, String code)
    : super(
        '/user/verifyCodeLogin',
        ReqMethod.post,
        parameters: {'account': account, 'code': code},
        encoding: ReqEncoding.json,
      );

  Api.accountGetUser() : super('/MeetAgain-user/checkUserLogin', ReqMethod.get);

  // ================================================================================

  Api.boxGetAll() : super('/MeetAgain-memoryBoxes/getMemoryBoxesByUserIdWithPet', ReqMethod.get);

  Api.boxGetOne(String boxId)
    : super(
        '/MeetAgain-memoryBoxes/getMemoryBoxById',
        ReqMethod.post,
        parameters: {'boxId': boxId},
        encoding: ReqEncoding.json,
      );

  Api.boxCreateHuman(String name, String? image, String? gender, String? age, String? figure)
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

  Api.boxCreatePet(
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

  Api.boxDelete(String boxId)
    : super(
        '/MeetAgain-memoryBoxes/deleteMemoryBox',
        ReqMethod.post,
        parameters: {'boxId': boxId},
        encoding: ReqEncoding.json,
      );

  Api.boxActivate(String boxId, String code)
    : super(
        '/MeetAgain-memoryBoxes/activateMemoryBox',
        ReqMethod.post,
        parameters: {'boxId': boxId, 'code': code},
        encoding: ReqEncoding.json,
      );

  Api.boxPreview(String boxId)
    : super(
        '/MeetAgain-memoryBoxes/generatePreview',
        ReqMethod.post,
        parameters: {'boxId': boxId},
        encoding: ReqEncoding.json,
      );

  Api.boxGetGests() : super('/MeetAgain-memoryBoxes/getAvailableActions', ReqMethod.get);
}
