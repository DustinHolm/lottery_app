class AppUser {
  String id;
  String name;

  AppUser({required this.id, required this.name});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  AppUser.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];

  @override
  bool operator ==(Object other) => other is AppUser && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
