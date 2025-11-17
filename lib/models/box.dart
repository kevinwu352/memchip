// {
//   "_id": "690c3ad3286f7cfef644c9a3",
//   "userId": "68fee0e3bd0220da8825d0a3",
//   "type": 1,
//   "status": 0,
//
//   "boxName": "gju",
//   "name": "tfD",
//
//   "coverImage": "https://cdn.paoxiaokeji.com/upload/1762409159052-24982.png",
//   "frontImage": "https://cdn.paoxiaokeji.com/upload/1762409159052-24982.png",
//   "photos": [
//     "https://cdn.paoxiaokeji.com/upload/1763023106498-60214.png",
//     "https://cdn.paoxiaokeji.com/upload/1763023128000-53460.png"
//   ],
//
//   "gender": "female",
//
//   "ageStage": "青年",
//   "bodyType": "标准",
//
//   "species": "狗",
//   "character": [
//     "贪吃"
//   ],
//   "tail": true,
//
//   "previewImages": [
//     "https://cdn.paoxiaokeji.com/meetAgain/doubaoImage/2025-11-14/1763101584767-yql6h3.png",
//     "https://cdn.paoxiaokeji.com/meetAgain/doubaoImage/2025-11-14/1763101584882-gi9mvj.png"
//   ],
//   "createdTime": "2025-11-06T06:06:11.208Z",
//   "canEdit": true
// }

enum BoxType {
  pet,
  human,
  unknown;

  factory BoxType.fromApi(int i) => i >= 0 && i <= 1 ? BoxType.values[i] : unknown;
}

enum BoxStatus {
  unknown,
  activated,
  previewed,
  generating,
  generated;

  factory BoxStatus.fromApi(int i) => i >= 0 && i < 5 ? BoxStatus.values[i] : unknown;

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
  BoxType type;
  BoxStatus status;
  String name;
  String coverImage;
  String frontImage;
  List<String> previewImages;
  DateTime createdTime;

  bool isHuman = true;

  Box({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.name,
    required this.coverImage,
    required this.frontImage,
    required this.previewImages,
    required this.createdTime,
  });

  factory Box.fromApi(Map<String, dynamic> json) {
    final id = json['_id'] as String;
    final userId = json['userId'] as String;
    final type = BoxType.fromApi(json['type'] as int);
    final status = BoxStatus.fromApi(json['status'] as int);

    final name1 = json['name'];
    final name2 = json['boxName'];
    final name = name1 is String
        ? name1
        : name2 is String
        ? name2
        : '';

    final cover = json['coverImage'];
    final front = json['frontImage'];
    final photosVal = json['photos'];
    List<String> photos = photosVal is List ? photosVal.whereType<String>().toList() : [];
    final coverImage = cover is String ? cover : (photos.elementAtOrNull(0) ?? '');
    final frontImage = front is String ? front : (photos.elementAtOrNull(1) ?? '');

    final previewImagesVal = json['previewImages'];
    List<String> previewImages = previewImagesVal is List ? previewImagesVal.whereType<String>().toList() : [];

    final createdTime = DateTime.parse(json['createdTime'] as String);
    return Box(
      id: id,
      userId: userId,
      type: type,
      status: status,
      name: name,
      coverImage: coverImage,
      frontImage: frontImage,
      previewImages: previewImages,
      createdTime: createdTime,
    );
  }
}
