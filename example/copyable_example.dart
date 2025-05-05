// lib/copyable_example.dart

import 'package:copyable_plus/copyable_plus.dart';
part 'copyable_example.copyable.dart';

@Copyable()
class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});
}
