import '/core/core.dart';

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

  User({required this.token, required this.id, required this.account, required this.nickname, required this.avatarUrl});

  factory User.mock() => User(
    token: '123456',
    id: 'uid123',
    account: 'kevin@local.com',
    nickname: 'kevin',
    avatarUrl: 'https://picsum.photos/200',
  );

  factory User.fromApi(Map<String, dynamic> json) {
    final token = json['token'] as String;
    final userInfo = json['userInfo'] as Map;
    final id = userInfo['_id'] as String;
    final account =
        [userInfo['email'], userInfo['phoneNumber'], userInfo['username']].whereType<String>().firstOrNull ?? '';
    final nickname = userInfo['nickname'] as String;
    final avatarUrl = userInfo['avatarUrl'] as String;
    return User(token: token, id: id, account: account, nickname: nickname, avatarUrl: avatarUrl);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final token = json.getString('token') ?? '';
    final id = json.getString('id') ?? '';
    final account = json.getString('account') ?? '';
    final nickname = json.getString('nickname') ?? '';
    final avatarUrl = json.getString('avatarUrl') ?? '';
    return User(token: token, id: id, account: account, nickname: nickname, avatarUrl: avatarUrl);
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'id': id,
    'account': account,
    'nickname': nickname,
    'avatarUrl': avatarUrl,
  };
}
