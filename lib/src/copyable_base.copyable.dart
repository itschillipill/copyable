// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// CopyableGenerator
// **************************************************************************

part of 'copyable_base.dart';

extension PersonExtension on Person {
  Person copyWith({String? name, int? age}) {
    return Person(name: name ?? this.name, age: age ?? this.age);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age};
  }

  static Person fromJson(Map<String, dynamic> json) {
    return Person(name: json['name'] as String, age: json['age'] as int);
  }
}
