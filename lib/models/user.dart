class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? username;
  String? phone;
  String? email;
  String? password;
  String? apiKey;
  String? profileImage;

  UserModel({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.phone,
    this.email,
    this.password,
    this.apiKey,
    this.profileImage,
  });

  static UserModel fromJson(json) => UserModel(
        id: json['confirm_user_id'] as String?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        username: json['username'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        apiKey: json['api_key'] as String?,
        profileImage: json['imgUrl'] as String?,
      );
}
