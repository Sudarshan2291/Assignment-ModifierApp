class UserModel {
  int? id;
  String name;
  String email;
  String imagePath;

  UserModel({this.id, required this.name, required this.email, required this.imagePath});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'imagePath': imagePath};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      imagePath: map['imagePath'],
    );
  }
}
