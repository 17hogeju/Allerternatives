class User {
  final String uid;
  final String email;

  User({ this.uid, this.email});

  User.fromData(Map<String, dynamic> data)
  : uid = data['id'],
  email = data['email'];

  Map<String, dynamic> toJson() {
    return {
      'uid' : uid,
      'email' : email,
    };
  }

  User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      uid: map['uid'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

}