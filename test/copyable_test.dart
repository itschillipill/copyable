import 'package:copyable_plus/src/copyable_base.dart';
import 'package:test/test.dart'; // Подключаем сгенерированный файл

void main() {
  group('copyable_plus Generator', () {
    test('copyWith returns new instance with overridden values', () {
      final person = Person(name: 'Alice', age: 25);
      final updated = person.copyWith(name: 'Bob');

      expect(updated.name, 'Bob');
      expect(updated.age, 25); // значение осталось как у исходного
    });

    test('toString returns expected string', () {
      final person = Person(name: 'Alice', age: 25);
      final expected = 'Person(name: Alice, age: 25)';
      print(person.toString());
      expect(person.toString(), expected);
    });
  });
}
