/// IBAN validation and formatting utilities for Pakistani bank accounts.
library;

/// Provides validation and utility methods for Pakistani IBANs.
///
/// Pakistani IBANs are 24 characters: `PK` + 2 check digits + 4-letter bank
/// code + 16 numeric digits.  The check digits are validated using the
/// ISO 13616 mod-97 algorithm.
///
/// Example:
/// ```dart
/// PkIban.isValid('PK36SCBL0000001123456702'); // true
/// PkIban.format('PK36SCBL0000001123456702');  // 'PK36 SCBL 0000 0011 2345 6702'
/// PkIban.getBankCode('PK36SCBL0000001123456702'); // 'SCBL'
/// ```
class PkIban {
  PkIban._();

  static final RegExp _raw = RegExp(r'^PK\d{2}[A-Z]{4}\d{16}$');

  /// Strips spaces and uppercases [input], returning the canonical raw form.
  static String _normalise(String input) =>
      input.trim().replaceAll(' ', '').toUpperCase();

  /// Validates the mod-97 checksum of [iban] (must already be normalised).
  static bool _mod97(String iban) {
    final rearranged = '${iban.substring(4)}${iban.substring(0, 4)}';
    final numeric = rearranged.split('').map((c) {
      final code = c.codeUnitAt(0);
      return code >= 65 ? (code - 55).toString() : c;
    }).join();
    var remainder = 0;
    for (final ch in numeric.split('')) {
      remainder = (remainder * 10 + int.parse(ch)) % 97;
    }
    return remainder == 1;
  }

  /// Returns `true` if [input] is a valid Pakistani IBAN.
  ///
  /// Checks format (`PK` + 2 digits + 4 letters + 16 digits) and the
  /// ISO 13616 mod-97 checksum.
  ///
  /// Example:
  /// ```dart
  /// PkIban.isValid('PK36SCBL0000001123456702'); // true
  /// PkIban.isValid('PK00SCBL0000001123456702'); // false (bad checksum)
  /// ```
  static bool isValid(String input) {
    final s = _normalise(input);
    return _raw.hasMatch(s) && _mod97(s);
  }

  /// Returns the IBAN in grouped display format: `PK36 SCBL 0000 0011 2345 6702`.
  ///
  /// Throws [FormatException] if [input] is not a valid Pakistani IBAN.
  ///
  /// Example:
  /// ```dart
  /// PkIban.format('PK36SCBL0000001123456702');
  /// // 'PK36 SCBL 0000 0011 2345 6702'
  /// ```
  static String format(String input) {
    if (!isValid(input)) throw FormatException('Invalid Pakistani IBAN: $input');
    final s = _normalise(input);
    final groups = <String>[];
    for (var i = 0; i < s.length; i += 4) {
      groups.add(s.substring(i, i + 4 > s.length ? s.length : i + 4));
    }
    return groups.join(' ');
  }

  /// Returns the 4-letter bank code embedded in the IBAN.
  ///
  /// Returns `null` if [input] is not a valid Pakistani IBAN.
  ///
  /// Example:
  /// ```dart
  /// PkIban.getBankCode('PK36SCBL0000001123456702'); // 'SCBL'
  /// ```
  static String? getBankCode(String input) {
    if (!isValid(input)) return null;
    return _normalise(input).substring(4, 8);
  }
}
