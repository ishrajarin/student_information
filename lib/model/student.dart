
class Student {
  int? id;
  String? name;
  String? studentid;
  String? phone;
  String? email;
  String? location;

  Student({this.id, this.name, this.studentid, this.phone, this.email, this.location});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'studentid': studentid,
      'phone': phone,
      'email': email,
      'location': location,

    };
  }

  static Student fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      studentid: map['studentid'],
      phone: map['phone'],
      email: map['email'],
      location: map['location'],
    );
  }
}
