class UserModel {
  String token;
  String id;
  String email;
  String nickname;
  String avatarUrl;
  String openId;
  String systemInfo;
  DateTime createTime;
  DateTime lastLoginTime;

  UserModel({
    required this.token,
    required this.id,
    required this.email,
    required this.nickname,
    required this.avatarUrl,
    required this.openId,
    required this.systemInfo,
    required this.createTime,
    required this.lastLoginTime,
  });

  factory UserModel.fromLogin(Map<String, dynamic> json) {
    final token = json['token'] as String;
    final userInfo = json['userInfo'] as Map;
    final id = userInfo['_id'] as String;
    final email = userInfo['email'] as String;
    final nickname = userInfo['nickname'] as String;
    final avatarUrl = userInfo['avatarUrl'] as String;
    final openId = userInfo['openId'] as String;
    final systemInfo = userInfo['systemInfo'] as String;
    final createTime = DateTime.parse(userInfo['createTime'] as String);
    final lastLoginTime = DateTime.parse(userInfo['lastLoginTime'] as String);
    return UserModel(
      token: token,
      id: id,
      email: email,
      nickname: nickname,
      avatarUrl: avatarUrl,
      openId: openId,
      systemInfo: systemInfo,
      createTime: createTime,
      lastLoginTime: lastLoginTime,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final token = json['token'] as String;
    final id = json['id'] as String;
    final email = json['email'] as String;
    final nickname = json['nickname'] as String;
    final avatarUrl = json['avatarUrl'] as String;
    final openId = json['openId'] as String;
    final systemInfo = json['systemInfo'] as String;
    final createTime = DateTime.parse(json['createTime'] as String);
    final lastLoginTime = DateTime.parse(json['lastLoginTime'] as String);
    return UserModel(
      token: token,
      id: id,
      email: email,
      nickname: nickname,
      avatarUrl: avatarUrl,
      openId: openId,
      systemInfo: systemInfo,
      createTime: createTime,
      lastLoginTime: lastLoginTime,
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'id': id,
    'email': email,
    'nickname': nickname,
    'avatarUrl': avatarUrl,
    'openId': openId,
    'systemInfo': systemInfo,
    'createTime': createTime.toIso8601String(),
    'lastLoginTime': lastLoginTime.toIso8601String(),
  };
}
