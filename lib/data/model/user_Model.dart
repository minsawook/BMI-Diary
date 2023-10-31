import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String uid;
    String name;
    String email;
    String profileUrl;

    UserModel({
        required this.uid,
        required this.name,
        required this.email,
        required this.profileUrl,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        profileUrl: json["profileUrl"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "profileUrl": profileUrl,
    };
}