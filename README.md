# String Calculator - Dart Console App (TDD Kata)

A Dart-based console application to solve the **String Calculator TDD Kata**, written with clean logic, detailed error handling, and full unit test coverage.

This project demonstrates **Test-Driven Development (TDD)** using Dart and Flutter's testing framework. It's built as a console utility and can also be extended to Flutter UI.

---

## Steps

1. Create a simple String calculator with a method signature like this:

   ```c
   int add(string numbers)
   ```

   - 🟢 **Input**: a string of comma-separated numbers
   - 🟢 **Output**: an integer, sum of the numbers

   ### Examples

   - 🟢 **Input**: `""`, **Output**: `0`
   - 🟢 **Input**: `"1"`, **Output**: `1`
   - 🟢 **Input**: `"1,5"`, **Output**: `6`

2. Allow the `add` method to handle any amount of numbers.

3. Allow the `add` method to handle new lines between numbers (instead of commas).
   Example: `"1\n2,3"` should return `6`.

---

## 💡 Project Overview

This project is a simple implementation of a **String Calculator** using Test-Driven Development (TDD). It demonstrates how to iteratively build functionality using unit tests and minimal code.

---

## Folder Architecture

```bash
string_calculator_tdd/
├── tool/
│ └── string_calculator.dart # Core calculator logic
├── test/
│ └── string_calculator_test.dart # Unit tests for the calculator
├── pubspec.yaml # Project metadata and dependencies
└── README.md # Project documentation
```

## String Calculator Codes

### string_calculator.dart

```bash
class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) return 0;

    // Default delimiters
    String delimiterPattern = ',|\n';
    String numberString = numbers;

    // Custom delimiter
    if (numbers.startsWith('//')) {
      final delimiterMatch = RegExp(r'^//(.+)\n').firstMatch(numbers);
      if (delimiterMatch != null) {
        String delimiter = RegExp.escape(delimiterMatch.group(1)!);
        delimiterPattern = delimiter;
        numberString = numbers.substring(delimiterMatch.end);
      }
    }

    final parts = numberString.split(RegExp(delimiterPattern));
    final parsedNumbers = parts.map(int.parse).toList();

    final negativeNumbers = parsedNumbers.where((n) => n < 0).toList();
    if (negativeNumbers.isNotEmpty) {
      throw Exception(
          'negative numbers not allowed: ${negativeNumbers.join(',')}');
    }

    return parsedNumbers.reduce((a, b) => a + b);
  }
}

```

```bash
void main() {
  final calculator = StringCalculator();

  print("String String Calculator");
  print(
      "Enter a string of numbers (use , or \\n or custom delimiter like //;\\n1;2):");

  while (true) {
    stdout.write("\n  Input: ");
    String? input = stdin
        .readLineSync()
        ?.replaceAll(r'\n', '\n') // Convert \n string into real newline
        .replaceAll('"', '') // Remove quotes if any
        .trim(); // Clean up whitespace

    if (input == null || input.trim().toLowerCase() == 'exit') {
      print("Exiting. Goodbye!");
      break;
    }

    try {
      print(input);
      int result = calculator.add(input);
      print("Result: $result");
    } catch (e) {
      print("Error: $e");
    }
  }
}

```

## Unit Test Codes

```bash
import 'package:flutter_test/flutter_test.dart';
import '../tool/string_calculator.dart';

void main() {
  final calculator = StringCalculator();

  test('Empty string returns 0', () {
    expect(calculator.add(''), 0);
  });

  test('Single number returns the number', () {
    expect(calculator.add('1'), 1);
  });

  test('Two numbers returns their sum', () {
    expect(calculator.add('1,5'), 6);
  });

  test('Multiple numbers return their sum', () {
    expect(calculator.add('1,2,3,4,5'), 15);
  });

  test('Handles new lines as delimiter', () {
    expect(calculator.add('1\n2,7'), 10);
  });

  test('Supports custom delimiter', () {
    expect(calculator.add('//;\n1;9'), 10);
  });
    test('Supports custom delimiter test 2', () {
    expect(calculator.add('//%\n5%7'), 12);
  });

  test('Throws exception for single negative number', () {
    expect(
        () => calculator.add('1,-2,3'),
        throwsA(predicate(
            (e) => e.toString().contains('negative numbers not allowed: -2'))));
  });

  test('Throws exception for multiple negative numbers', () {
    expect(
        () => calculator.add('-1,2,-3'),
        throwsA(predicate((e) =>
            e.toString().contains('negative numbers not allowed: -1,-3'))));
  });
}

```

## How to Run Tests

Use the following command to execute all tests:

```bash
flutter test
```

## Test Result

```bash
00:00 +0: loading D:/Flutter Projects/string_calculator_tdd/test/string_calculator_test.dart
00:00 +0: Empty string returns 0
00:00 +1: Single number returns the number
00:00 +2: Two numbers returns their sum
00:00 +3: Multiple numbers return their sum
00:00 +4: Handles new lines as delimiter
00:00 +5: Supports custom delimiter
00:00 +6: Supports custom delimiter test 2
00:00 +7: Throws exception for single negative number
00:00 +8: Throws exception for multiple negative numbers
00:00 +9: All tests passed!
```
