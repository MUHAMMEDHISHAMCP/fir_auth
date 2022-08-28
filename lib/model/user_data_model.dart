class UserData {
  String? email;
  String? phoneNo;
  String? image;
  String? name;
  String? id;

  UserData({
    this.email,
    this.image,
    this.id,
    this.name,
    this.phoneNo,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        email: json["email"],
        name: json["name"],
        phoneNo: json["phoneNo"],
        id: json["uid"],
        image: json["profile"],
      );

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "phoneNo": phoneNo,
      "uid": id,
      "profile": image
    };
  }
}
