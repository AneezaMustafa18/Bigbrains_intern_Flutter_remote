class UserModel {
  final String id;
  final String ownerId;
  final String name;
  final String email;
  final int age;

  UserModel({
    this.id = '',
    required this.ownerId,
    required this.name,
    required this.email,
    required this.age,
  });

  // Convert UserModel → Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'name': name,
      'email': email,
      'age': age,
    };
  }

  // Convert Firestore Document → UserModel
  factory UserModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return UserModel(
      id: id,
      ownerId: map['ownerId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? 0,
    );
  }
}