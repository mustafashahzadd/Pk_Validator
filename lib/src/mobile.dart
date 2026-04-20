/// Mobile number validation and formatting utilities for Pakistani numbers.
library;

/// Provides validation and utility methods for Pakistani mobile numbers.
///
/// Accepts numbers in multiple formats:
/// - `03001234567`
/// - `3001234567`
/// - `+923001234567`
/// - `923001234567`
/// - `0092 300 1234567`
///
/// Example:
/// ```dart
/// PkMobile.isValid('+923001234567');      // true
/// PkMobile.toLocal('+923001234567');      // '03001234567'
/// PkMobile.getNetwork('03001234567');     // 'Jazz'
/// ```
class PkMobile {
  PkMobile._();

  static final RegExp _normalised = RegExp(r'^3[0-9]{9}$');

  /// Strips all formatting and returns bare 10-digit local number (e.g. `3001234567`).
  ///
  /// Returns `null` if [input] cannot be parsed as a Pakistani mobile number.
  ///
  /// Example:
  /// ```dart
  /// PkMobile._bare('+923001234567'); // '3001234567'
  /// ```
  static String? _bare(String input) {
    var s = input.trim().replaceAll(RegExp(r'[\s\-()]'), '');
    if (s.startsWith('+92')) {
      s = s.substring(3);
    } else if (s.startsWith('0092')) {
      s = s.substring(4);
    } else if (s.startsWith('92') && s.length == 12) {
      s = s.substring(2);
    } else if (s.startsWith('0')) {
      s = s.substring(1);
    }
    if (!_normalised.hasMatch(s)) return null;
    return s;
  }

  /// Returns `true` if [input] is a valid Pakistani mobile number.
  ///
  /// Accepts `03001234567`, `+923001234567`, `923001234567`, `0092 300 1234567`.
  ///
  /// Example:
  /// ```dart
  /// PkMobile.isValid('03001234567');  // true
  /// PkMobile.isValid('12345');        // false
  /// ```
  static bool isValid(String input) => _bare(input) != null;

  /// Returns the number in human-readable format: `+92 300 1234567`.
  ///
  /// Throws [FormatException] if [input] is not a valid Pakistani mobile number.
  ///
  /// Example:
  /// ```dart
  /// PkMobile.format('03001234567'); // '+92 300 1234567'
  /// ```
  static String format(String input) {
    final b = _bare(input);
    if (b == null) throw FormatException('Invalid Pakistani mobile number: $input');
    return '+92 ${b.substring(0, 3)} ${b.substring(3)}';
  }

  /// Returns the number in international E.164 format: `+923001234567`.
  ///
  /// Throws [FormatException] if [input] is not a valid Pakistani mobile number.
  ///
  /// Example:
  /// ```dart
  /// PkMobile.toInternational('03001234567'); // '+923001234567'
  /// ```
  static String toInternational(String input) {
    final b = _bare(input);
    if (b == null) throw FormatException('Invalid Pakistani mobile number: $input');
    return '+92$b';
  }

  /// Returns the number in local Pakistani format: `03001234567`.
  ///
  /// Throws [FormatException] if [input] is not a valid Pakistani mobile number.
  ///
  /// Example:
  /// ```dart
  /// PkMobile.toLocal('+923001234567'); // '03001234567'
  /// ```
  static String toLocal(String input) {
    final b = _bare(input);
    if (b == null) throw FormatException('Invalid Pakistani mobile number: $input');
    return '0$b';
  }

  /// Returns the network operator name for a Pakistani mobile number.
  ///
  /// Returns `null` if [input] is invalid or the prefix is unrecognised.
  ///
  /// | Prefix range | Network       |
  /// |--------------|---------------|
  /// | 0300–0309    | Jazz          |
  /// | 0310–0319    | Zong          |
  /// | 0320–0325    | Warid (Jazz)  |
  /// | 0330–0337    | Ufone         |
  /// | 0340–0349    | Telenor       |
  /// | 0355         | SCOM          |
  ///
  /// Example:
  /// ```dart
  /// PkMobile.getNetwork('03001234567'); // 'Jazz'
  /// PkMobile.getNetwork('03101234567'); // 'Zong'
  /// ```
  static String? getNetwork(String input) {
    final b = _bare(input);
    if (b == null) return null;
    final prefix = int.parse(b.substring(0, 3));
    if (prefix >= 300 && prefix <= 309) return 'Jazz';
    if (prefix >= 310 && prefix <= 319) return 'Zong';
    if (prefix >= 320 && prefix <= 325) return 'Warid (Jazz)';
    if (prefix >= 330 && prefix <= 337) return 'Ufone';
    if (prefix >= 340 && prefix <= 349) return 'Telenor';
    if (prefix == 355) return 'SCOM';
    return null;
  }
}
