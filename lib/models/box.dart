// {
//   "_id": "690c3ad3286f7cfef644c9a3",
//   "userId": "68fee0e3bd0220da8825d0a3",
//   "boxName": "gju",
//   "coverImage": "https://cdn.paoxiaokeji.com/upload/1762409159052-24982.png",
//   "frontImage": "https://cdn.paoxiaokeji.com/upload/1762409159052-24982.png",
//   "gender": "female",
//   "ageStage": "青年",
//   "bodyType": "标准",
//   "status": 0,
//   "createdTime": "2025-11-06T06:06:11.208Z",
//   "updatedTime": "2025-11-06T06:06:11.208Z",
//   "canEdit": true
// }

class Box {
  String id;
  String userId;
  String boxName;
  String coverImage;
  String frontImage;
  String gender;
  String ageStage;
  String bodyType;
  int status;
  bool canEdit;
  DateTime createdTime;
  DateTime updatedTime;

  Box({
    required this.id,
    required this.userId,
    required this.boxName,
    required this.coverImage,
    required this.frontImage,
    required this.gender,
    required this.ageStage,
    required this.bodyType,
    required this.status,
    required this.canEdit,
    required this.createdTime,
    required this.updatedTime,
  });

  factory Box.fromApi(Map<String, dynamic> json) {
    final id = json['_id'] as String;
    final userId = json['userId'] as String;
    final boxName = json['boxName'] as String;
    final coverImage = json['coverImage'] as String;
    final frontImage = json['frontImage'] as String;
    final gender = json['gender'] as String;
    final ageStage = json['ageStage'] as String;
    final bodyType = json['bodyType'] as String;
    final status = json['status'] as int;
    final canEdit = json['canEdit'] as bool;
    final createdTime = DateTime.parse(json['createdTime'] as String);
    final updatedTime = DateTime.parse(json['updatedTime'] as String);
    return Box(
      id: id,
      userId: userId,
      boxName: boxName,
      coverImage: coverImage,
      frontImage: frontImage,
      gender: gender,
      ageStage: ageStage,
      bodyType: bodyType,
      status: status,
      canEdit: canEdit,
      createdTime: createdTime,
      updatedTime: updatedTime,
    );
  }
}
