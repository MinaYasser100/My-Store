class UserModel {
  final String email;
  final String uid;
  final String firstName;
  final String lastName;

  UserModel({
    required this.email,
    required this.uid,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      uid: map['uid'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }
}
