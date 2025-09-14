import 'package:app_utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Email Validation', () {
    test('Valid email', () {
      expect(checkEmailValidation('test@example.com'), true);
      expect(checkEmailValidation('erfan.eg_tag@gmail.com'), true);
    });

    test('Invalid email', () {
      expect(checkEmailValidation(''), false);
      expect(checkEmailValidation('dsfgsds5f'), false);
      expect(checkEmailValidation('aasdfad@hdfgfhj'), false);
      expect(checkEmailValidation('f78uhyjghjk@.com'), false);
    });
  });

  group('Password Validation', () {
    test('Password with valid length', () {
      expect(checkPasswordValidation('123456'), true);
      expect(checkPasswordValidation('dsd.fg4353!'), true);
    });

    test('Password too short', () {
      expect(checkPasswordValidation('12345'), false);
      expect(checkPasswordValidation(''), false);
    });
  });

  group('Format Price', () {
    test('Without decimals', () {
      expect(formatPrice('1000'), '1,000');
      expect(formatPrice('1234567'), '1,234,567');
    });

    test('with decimals', () {
      expect(formatPrice('1234.5'), '1,234.5');
      expect(formatPrice('4567.567'), '4,567.56');
      expect(formatPrice('1234.57'), '1,234.57');
    });

    test('Negative numbers', () {
      expect(formatPrice('-1234.5'), '-1,234.5');
      expect(formatPrice('-4567.567'), '-4,567.56');
      expect(formatPrice('-1234.57'), '-1,234.57');
    });

    test('Handles malformed input', () {
      expect(formatPrice('ew45w'), '0'); // fallback
      expect(formatPrice(''), '0');
    });
  });

  group('Random ID', () {
    test('UUID v4', () {
      final id1 = getRandomID();

      expect(id1, isNotEmpty);
    });
  });
}
