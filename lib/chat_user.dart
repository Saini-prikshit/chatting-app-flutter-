class ChatUser {
  late final String name;
  late final String about;
  late final String id;
  late final bool isOnline;
  late final String lastActive;
  late final String eMail;
  late final String pushToken;
  late final String? image;

  ChatUser({
    required this.name,
    required this.about,
    required this.id,
    required this.isOnline,
    required this.lastActive,
    required this.eMail,
    required this.pushToken,
    this.image,
  });

  ChatUser.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    about = json['about'] ?? '';
    id = json['id'] ?? '';
    isOnline = json['isOnline'] ?? '';
    lastActive = json['lastActive'] ?? '';
    eMail = json['eMail'] ?? '';
    pushToken = json['pushToken'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['about'] = about;
    data['id'] = id;
    data['isOnline'] = isOnline;
    data['lastActive'] = lastActive;
    data['eMail'] = eMail;
    data['pushToken'] = pushToken;
    data['image'] = image;
    return data;
  }
}
