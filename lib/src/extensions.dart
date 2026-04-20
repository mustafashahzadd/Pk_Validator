/// Ergonomic String extension methods for Pakistani validators.
library;

import 'cnic.dart';
import 'iban.dart';
import 'mobile.dart';

/// Convenient String extensions for `pk_validators`.
///
/// Instead of calling static methods, you can use these extensions directly
/// on any `String`:
///
/// Example:
/// ```dart
/// '42101-1234567-8'.isValidPkCnic;   // true
/// '03001234567'.formatPkMobile;       // '+92 300 1234567'
/// 'PK36SCBL0000001123456702'.pkIbanBankCode; // 'SCBL'
/// ```
extension PkValidatorsStringX on String {
  /// Returns `true` if this string is a valid Pakistani CNIC.
  ///
  /// Example:
  /// ```dart
  /// '42101-1234567-8'.isValidPkCnic; // true
  /// ```
  bool get isValidPkCnic => PkCnic.isValid(this);

  /// Returns `true` if this string is a valid Pakistani mobile number.
  ///
  /// Example:
  /// ```dart
  /// '03001234567'.isValidPkMobile; // true
  /// ```
  bool get isValidPkMobile => PkMobile.isValid(this);

  /// Returns `true` if this string is a valid Pakistani IBAN.
  ///
  /// Example:
  /// ```dart
  /// 'PK36SCBL0000001123456702'.isValidPkIban; // true
  /// ```
  bool get isValidPkIban => PkIban.isValid(this);

  /// Returns this CNIC formatted as `XXXXX-XXXXXXX-X`.
  ///
  /// Throws [FormatException] if the string is not a valid CNIC.
  ///
  /// Example:
  /// ```dart
  /// '4210112345678'.formatPkCnic; // '42101-1234567-8'
  /// ```
  String get formatPkCnic => PkCnic.format(this);

  /// Returns this mobile number formatted as `+92 300 1234567`.
  ///
  /// Throws [FormatException] if the string is not a valid Pakistani mobile number.
  ///
  /// Example:
  /// ```dart
  /// '03001234567'.formatPkMobile; // '+92 300 1234567'
  /// ```
  String get formatPkMobile => PkMobile.format(this);

  /// Returns this IBAN formatted in groups of 4: `PK36 SCBL 0000 0011 2345 6702`.
  ///
  /// Throws [FormatException] if the string is not a valid Pakistani IBAN.
  ///
  /// Example:
  /// ```dart
  /// 'PK36SCBL0000001123456702'.formatPkIban;
  /// // 'PK36 SCBL 0000 0011 2345 6702'
  /// ```
  String get formatPkIban => PkIban.format(this);

  /// Returns the mobile network operator for this number, or `null`.
  ///
  /// Example:
  /// ```dart
  /// '03001234567'.pkMobileNetwork; // 'Jazz'
  /// ```
  String? get pkMobileNetwork => PkMobile.getNetwork(this);

  /// Returns the province associated with this CNIC's first digit, or `null`.
  ///
  /// Example:
  /// ```dart
  /// '42101-1234567-8'.pkCnicProvince; // 'Sindh'
  /// ```
  String? get pkCnicProvince => PkCnic.getProvince(this);
}
