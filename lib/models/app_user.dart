import 'address.dart';

class AppUser {
  String name;
  Address address;

  AppUser({required this.name, required this.address});

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  AppUser.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        address = Address();
}
