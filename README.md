# 📦 copyable_plus

A Dart annotation and code generator that creates `copyWith`, `toJson`, and `fromJson` methods for your immutable classes.

---

![Pub Version](https://img.shields.io/pub/v/copyable_plus)
![Dart](https://img.shields.io/badge/dart-%5E3.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

---

## ✨ Features

✅ Generates `copyWith()`  
✅ Supports `toJson()` and `fromJson()`  
✅ Works with nested models and lists  
✅ Null-safe  
✅ Lightweight and easy to use

---

## 🚀 Getting Started

### 1️⃣ Add Dependencies

```yaml
dependencies:
  copyable_plus: ^0.1.0

dev_dependencies:
  build_runner: ^2.4.6
  source_gen: ^1.5.0
```
2️⃣ Annotate Your Class
```dart
import 'package:copyable_plus/copyable_plus.dart';

part 'person.copyable_plus.dart';

@copyable_plus()
class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});
}
```

3️⃣ Generate Code
Run this in your terminal:

```bash
dart run build_runner build
```

This will generate a *.copyable_plus.dart file with:

copyWith() method

toJson() method

fromJson() static constructor