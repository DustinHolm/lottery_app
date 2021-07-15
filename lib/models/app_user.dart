class AppUser {
  String id;
  String? name;
  String? email;
  int? tickets;

  AppUser({required this.id, this.name, this.email, this.tickets});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "tickets": tickets,
      };

  AppUser.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        email = json["email"],
        tickets = json["tickets"];

  @override
  bool operator ==(Object other) => other is AppUser && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
