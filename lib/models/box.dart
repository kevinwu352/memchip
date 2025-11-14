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
//   "previewImages": [
//     "https://cdn.paoxiaokeji.com/meetAgain/doubaoImage/2025-11-14/1763101584767-yql6h3.png",
//     "https://cdn.paoxiaokeji.com/meetAgain/doubaoImage/2025-11-14/1763101584882-gi9mvj.png"
//   ],
//   "createdTime": "2025-11-06T06:06:11.208Z",
//   "updatedTime": "2025-11-06T06:06:11.208Z",
//   "canEdit": true
// }

enum BoxStatus {
  unknown,
  activated,
  previewed,
  generating,
  generated;

  factory BoxStatus.fromIndex(int i) => i >= 0 && i < 5 ? BoxStatus.values[i] : unknown;

  int get stack {
    switch (this) {
      case unknown:
        return 0;
      case activated:
        return 1;
      case previewed:
        return 2;
      case generating:
        return 2;
      case generated:
        return 3;
    }
  }
}

class Box {
  String id;
  String userId;
  String boxName;
  String coverImage;
  String frontImage;
  String gender;
  String ageStage;
  String bodyType;
  BoxStatus status;
  List<String> previewImages;
  bool canEdit;
  DateTime createdTime;
  DateTime updatedTime;

  bool isHuman = true;

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
    required this.previewImages,
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
    final status = BoxStatus.fromIndex(json['status'] as int);
    final previewImagesVal = json['previewImages'];
    List<String> previewImages = previewImagesVal is List ? previewImagesVal.whereType<String>().toList() : [];
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
      previewImages: previewImages,
      canEdit: canEdit,
      createdTime: createdTime,
      updatedTime: updatedTime,
    );
  }
}
