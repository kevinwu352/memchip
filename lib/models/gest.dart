// {
//   "action": "看书",
//   "icon": "📚",
//   "selected": false
// }

class Gest {
  String action;
  String icon;

  Gest({required this.action, required this.icon});

  factory Gest.fromApi(Map<String, dynamic> json) {
    final action = json['action'] as String;
    final icon = json['icon'] as String;
    return Gest(action: action, icon: icon);
  }
}
