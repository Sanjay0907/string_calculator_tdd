// ignore_for_file: avoid_print

import 'dart:io';

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
