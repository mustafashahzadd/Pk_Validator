/// A lightweight, zero-dependency, pure-Dart package that validates and
/// formats Pakistan-specific inputs: CNIC numbers, mobile numbers, and IBANs.
///
/// ## Quick start
///
/// ```dart
/// import 'package:pk_validators/pk_validators.dart';
///
/// // Static API
/// PkCnic.isValid('42101-1234567-8');   // true
/// PkMobile.toLocal('+923001234567');    // '03001234567'
/// PkIban.getBankCode('PK36SCBL0000001123456702'); // 'SCBL'
///
/// // Extension API
/// '42101-1234567-8'.isValidPkCnic;     // true
/// '03001234567'.pkMobileNetwork;        // 'Jazz'
/// ```
library;

export 'src/cnic.dart';
export 'src/extensions.dart';
export 'src/iban.dart';
export 'src/mobile.dart';
