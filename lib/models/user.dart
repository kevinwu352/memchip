// {
//   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OGZlZTBlM2JkMDIyMGRhODgyNWQwYTMiLCJpYXQiOjE3NjI0MjA0MDAsImV4cCI6MTc2NTAxMjQwMH0.MFor4iKYuh_SdOwlxHntmmqVcd0whI5QE7tgOxNFOws",
//   "userInfo": {
//     "_id": "68fee0e3bd0220da8825d0a3",
//     "email": "wuhp@proton.me",
//     "nickname": "风拂柳丝_710",
//     "avatarUrl": "https://cdn.paoxiaokeji.com/meetAgain/defaultHeadImg/defaultImg4.webp",
//     "openId": "wuhp@proton.me_openid",
//     "systemInfo": "",
//     "createTime": "2025-10-27T03:02:59.699Z",
//     "lastLoginTime": "2025-11-06T09:13:20.275Z",
//     "openid": "wuhp@proton.me_openid",
//     "hasPet": true,
//     "updateTime": "2025-11-06T06:06:49.035Z"
//   }
// }

class User {
  String token;
  String id;
  String account;
  String nickname;
  String avatarUrl;
  String openId;
  DateTime createTime;
  DateTime lastLoginTime;

  User({
    required this.token,
    required this.id,
    required this.account,
    required this.nickname,
    required this.avatarUrl,
    required this.openId,
    required this.createTime,
    required this.lastLoginTime,
  });

  factory User.mock() => User(
    token: '123456',
    id: 'uid123',
    account: 'kevin@local.com',
    nickname: 'kevin',
    avatarUrl: 'https://picsum.photos/200',
    openId: 'oid123',
    createTime: DateTime.now(),
    lastLoginTime: DateTime.now(),
  );

  factory User.fromApi(Map<String, dynamic> json) {
    final token = json['token'] as String;
    final userInfo = json['userInfo'] as Map;
    final id = userInfo['_id'] as String;

    final email = userInfo['email'];
    final phone = userInfo['phoneNumber'];
    final username = userInfo['username'];
    final account = email is String
        ? email
        : phone is String
        ? phone
        : username is String
        ? username
        : '';

    final nickname = userInfo['nickname'] as String;
    final avatarUrl = userInfo['avatarUrl'] as String;
    final openId = userInfo['openId'] as String;
    final createTime = DateTime.parse(userInfo['createTime'] as String);
    final lastLoginTime = DateTime.parse(userInfo['lastLoginTime'] as String);
    return User(
      token: token,
      id: id,
      account: account,
      nickname: nickname,
      avatarUrl: avatarUrl,
      openId: openId,
      createTime: createTime,
      lastLoginTime: lastLoginTime,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final token = json['token'] as String;
    final id = json['id'] as String;
    final account = json['account'] as String;
    final nickname = json['nickname'] as String;
    final avatarUrl = json['avatarUrl'] as String;
    final openId = json['openId'] as String;
    final createTime = DateTime.parse(json['createTime'] as String);
    final lastLoginTime = DateTime.parse(json['lastLoginTime'] as String);
    return User(
      token: token,
      id: id,
      account: account,
      nickname: nickname,
      avatarUrl: avatarUrl,
      openId: openId,
      createTime: createTime,
      lastLoginTime: lastLoginTime,
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'id': id,
    'account': account,
    'nickname': nickname,
    'avatarUrl': avatarUrl,
    'openId': openId,
    'createTime': createTime.toIso8601String(),
    'lastLoginTime': lastLoginTime.toIso8601String(),
  };
}
