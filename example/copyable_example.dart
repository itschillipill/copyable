// lib/copyable_example.dart

import 'package:copyable/copyable.dart';
part 'copyable_example.copyable.dart';

@Copyable()
class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});
}
