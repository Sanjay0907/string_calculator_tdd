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
