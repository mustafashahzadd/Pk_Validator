/// CNIC validation and formatting utilities for Pakistani identity cards.
library;

/// Provides validation and utility methods for Pakistani CNIC numbers.
///
/// CNIC (Computerized National Identity Card) numbers are 13 digits,
/// optionally formatted as `XXXXX-XXXXXXX-X`.
///
/// Example:
/// ```dart
/// PkCnic.isValid('42101-1234567-8'); // true
/// PkCnic.format('4210112345678');    // '42101-1234567-8'
/// PkCnic.getProvince('42101-1234567-8'); // 'Sindh'
/// ```
class PkCnic {
  PkCnic._();

  static final RegExp _formatted = RegExp(r'^\d{5}-\d{7}-\d$');
  static final RegExp _unformatted = RegExp(r'^\d{13}$');

  /// Returns `true` if [input] is a valid CNIC in formatted or raw form.
  ///
  /// Accepts both `42101-1234567-8` and `4210112345678`.
  ///
  /// Example:
  /// ```dart
  /// PkCnic.isValid('42101-1234567-8'); // true
  /// PkCnic.isValid('1234');            // false
  /// ```
  static bool isValid(String input) {
    final s = input.trim();
    return _formatted.hasMatch(s) || _unformatted.hasMatch(s);
  }

  /// Returns the CNIC in `XXXXX-XXXXXXX-X` formatted form.
  ///
  /// Throws [FormatException] if [input] is not a valid CNIC.
  ///
  /// Example:
  /// ```dart
  /// PkCnic.format('4210112345678'); // '42101-1234567-8'
  /// ```
  static String format(String input) {
    final digits = unformat(input);
    if (digits.length != 13) {
      throw FormatException('Invalid CNIC: $input');
    }
    return '${digits.substring(0, 5)}-${digits.substring(5, 12)}-${digits.substring(12)}';
  }

  /// Returns the raw 13-digit CNIC string with all dashes removed.
  ///
  /// Throws [FormatException] if [input] is not a valid CNIC.
  ///
  /// Example:
  /// ```dart
  /// PkCnic.unformat('42101-1234567-8'); // '4210112345678'
  /// ```
  static String unformat(String input) {
    final s = input.trim().replaceAll('-', '');
    if (!_unformatted.hasMatch(s)) {
      throw FormatException('Invalid CNIC: $input');
    }
    return s;
  }

  /// Returns the province name based on the first digit of the CNIC.
  ///
  /// Returns `null` if [input] is invalid or the digit is unrecognised.
  ///
  /// | Digit | Province        |
  /// |-------|-----------------|
  /// | 1     | KPK             |
  /// | 2     | FATA            |
  /// | 3     | Punjab          |
  /// | 4     | Sindh           |
  /// | 5     | Balochistan     |
  /// | 6     | Islamabad       |
  /// | 7     | AJK             |
  /// | 8     | Gilgit-Baltistan|
  ///
  /// Example:
  /// ```dart
  /// PkCnic.getProvince('42101-1234567-8'); // 'Sindh'
  /// ```
  static String? getProvince(String input) {
    if (!isValid(input)) return null;
    final digits = input.trim().replaceAll('-', '');
    const map = {
      '1': 'KPK',
      '2': 'FATA',
      '3': 'Punjab',
      '4': 'Sindh',
      '5': 'Balochistan',
      '6': 'Islamabad',
      '7': 'AJK',
      '8': 'Gilgit-Baltistan',
    };
    return map[digits[0]];
  }

  /// Returns the gender derived from the last digit of the CNIC.
  ///
  /// Odd last digit → `'Male'`, even last digit → `'Female'`.
  /// Returns `null` if [input] is invalid.
  ///
  /// Example:
  /// ```dart
  /// PkCnic.getGender('42101-1234567-8'); // 'Female'
  /// PkCnic.getGender('42101-1234567-3'); // 'Male'
  /// ```
  static String? getGender(String input) {
    if (!isValid(input)) return null;
    final digits = input.trim().replaceAll('-', '');
    final last = int.parse(digits[digits.length - 1]);
    return last.isOdd ? 'Male' : 'Female';
  }
}
