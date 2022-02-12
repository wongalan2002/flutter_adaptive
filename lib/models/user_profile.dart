class UserProfile {
  late String? name;
  late String? id;
  late String? email;
  late String? schoolName;
  late String? post;
  late String? phone;
  late String? locale;

  UserProfile(
      {this.name,
        this.id,
        this.email,
        this.schoolName,
        this.post,
        this.phone,
        this.locale});

  toJson() {
    return {
      "name": name,
      "id": id,
      "email": email,
      "schoolName": schoolName,
      "post": post,
      "phone": phone,
      "locale": locale,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      id: json['id'],
      email: json['email'],
      schoolName: json['schoolName'],
      post: json['post'],
      phone: json['phone'],
      locale: json['locale'],
    );
  }
}
