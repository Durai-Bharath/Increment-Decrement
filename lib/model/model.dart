import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Model {
  String? name;
  String? password;
  int? value;
  Model({
    this.name,
    this.password,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'password': password,
      'value': value,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      name: map['name'] != null ? map['name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      value: map['value'] != null ? map['value'] as int : null,
    );
  }
}
