enum Gender { Male, Female }

class UserModel {
  bool? isAdmin;
  String? name;
  String? email;
  String? password;
  num? age;
  Gender? gender;
  String? city;
  String? id;
  UserModel(
      {required this.name,
      required this.age,
      required this.city,
      required this.email,
      required this.gender,
      required this.password});
  UserModel.fromMap(Map<String, dynamic> map) {
    gender = map['gender'] == 'male' ? Gender.Male : Gender.Female;
    name = map['name'];
    age = map['age'];
    city = map['city'];
    email = map['email'];
    id = map['id'];
    isAdmin = map['isAdmin'] ?? false;
    password = '';
  }
  toMap() {
    return {
      "name": name,
      "gender": gender == Gender.Male ? 'Male' : 'Female',
      "email": email,
      "city": city,
      "age": age,
      'id': id ?? 'not defeined'
    };
  }
}
