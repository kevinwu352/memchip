import '/core/core.dart';

// {
//   "createdTime": "2025-11-06T06:06:11.208Z",
//   "canEdit": true,
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
//
//   "generateImage": "https://cdn.paoxiaokeji.com/meetAgain/doubaoImage/2025-11-18/1763434843715-16kkx8.png",
//   "videoUrls": [{
//     "action": "默认动作",
//     "videoUrl": "",
//     "isDefault": true
//   }]
// }

enum BoxType {
  pet,
  human,
  unknown;

  factory BoxType.fromApi(int i) => i >= 0 && i < 2 ? BoxType.values[i] : unknown;
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
  DateTime createdTime;
  String id;
  BoxType type;
  BoxStatus status;
  String name;
  String coverImage;
  String frontImage;
  List<String> previewImages;
  String? generateImage;

  Box({
    required this.createdTime,
    required this.id,
    required this.type,
    required this.status,
    required this.name,
    required this.coverImage,
    required this.frontImage,
    required this.previewImages,
    this.generateImage,
  });

  factory Box.fromApi(Map<String, dynamic> json) {
    final createdTime = DateTime.parse(json['createdTime'] as String);
    final id = json['_id'] as String;
    final type = BoxType.fromApi(json['type'] as int);
    final status = BoxStatus.fromApi(json['status'] as int);
    final name = [json['name'], json['boxName']].whereType<String>().firstOrNull ?? '';
    final photos = json.getListOf<String>('photos');
    final coverImage = [json['coverImage'], photos?.elementAtOrNull(0)].whereType<String>().firstOrNull ?? '';
    final frontImage = [json['frontImage'], photos?.elementAtOrNull(1)].whereType<String>().firstOrNull ?? '';
    final previewImages = json.getListOf<String>('previewImages') ?? [];
    final generateImage = withValue(json['generateImage'], (v) => v is String ? v : null);
    return Box(
      createdTime: createdTime,
      id: id,
      type: type,
      status: status,
      name: name,
      coverImage: coverImage,
      frontImage: frontImage,
      previewImages: previewImages,
      generateImage: generateImage,
    );
  }
}
