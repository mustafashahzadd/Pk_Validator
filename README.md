# 🇵🇰 pk_validators

[![pub package](https://img.shields.io/pub/v/pk_validators.svg)](https://pub.dev/packages/pk_validators)
[![pub points](https://img.shields.io/pub/points/pk_validators)](https://pub.dev/packages/pk_validators/score)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)](https://dart.dev)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20Android%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-green)](https://pub.dev/packages/pk_validators)

> **The only Dart package you need for Pakistani identity validation.**
> Validate CNICs, mobile numbers, and IBANs in one line of code.

A lightweight, **zero-dependency**, pure-Dart package that validates and formats
Pakistan-specific inputs: **CNIC numbers**, **mobile numbers**, and **IBANs**.

Works in every Flutter and pure-Dart project on all **6 platforms** (iOS,
Android, Web, Windows, macOS, Linux).

---

## 📸 Screenshots

| 🪪 CNIC Validator | 📱 Mobile Validator |
|:-:|:-:|
| [![CNIC](https://raw.githubusercontent.com/mustafashahzadd/Pk_Validator/main/Screenshots/cnic.png)](https://raw.githubusercontent.com/mustafashahzadd/Pk_Validator/main/Screenshots/cnic.png) | [![Mobile](https://raw.githubusercontent.com/mustafashahzadd/Pk_Validator/main/Screenshots/mobile.png)](https://raw.githubusercontent.com/mustafashahzadd/Pk_Validator/main/Screenshots/mobile.png) |

| 🏦 IBAN — Invalid Input | 🏦 IBAN — Valid Input |
|:-:|:-:|
| [![IBAN Invalid](https://raw.githubusercontent.com/mustafashahzadd/Pk_Validator/main/Screenshots/iban_invalid.png)](https://raw.githubusercontent.com/mustafashahzadd/Pk_Validator/main/Screenshots/iban_invalid.png) | [![IBAN Valid](https://raw.githubusercontent.com/mustafashahzadd/Pk_Validator/main/Screenshots/iban_valid.png)](https://raw.githubusercontent.com/mustafashahzadd/Pk_Validator/main/Screenshots/iban_valid.png) |

---

## 🤔 Why this package?

Every Pakistani Flutter developer ends up writing the same 30 lines of
regex. Again. In every project. Then a teammate edits it and breaks edge cases.

**Before** (the usual mess):

```dart
// Somewhere buried in utils.dart, written at 2am
bool isValidCnic(String s) {
  return RegExp(r'^\d{5}-?\d{7}-?\d$').hasMatch(s); // ← wrong, misses length check
}
```

**After** (clean, readable, tested):

```dart
'42101-1234567-8'.isValidPkCnic   // true
'42101-1234567-8'.pkCnicProvince  // 'Sindh'
'03001234567'.pkMobileNetwork     // 'Jazz'
```

One import. Done.

---

## ✨ Features

- 🪪 **CNIC** — validate, format/unformat, detect province & gender
- 📱 **Mobile** — validate all Pakistani number formats, convert between
  local/international, detect network operator
- 🏦 **IBAN** — validate with ISO 13616 mod-97 checksum, format in groups,
  extract bank code
- 🔡 **String extensions** — ergonomic `.isValidPkCnic`, `.formatPkMobile`,
  `.pkMobileNetwork`, and more
- ⚡ **Zero runtime dependencies** — only `dart:core`
- 🔒 **Null-safe** — SDK `>=3.0.0`
- 🧪 **41 tests** — fully tested, production ready

---

## 🚀 Installation

```yaml
dependencies:
  pk_validators: ^0.1.0
```

```bash
dart pub get
```

---

## 📖 Usage

### 🪪 CNIC

```dart
import 'package:pk_validators/pk_validators.dart';

// Validation
PkCnic.isValid('42101-1234567-8');  // true
PkCnic.isValid('4210112345678');    // true  (unformatted also works)
PkCnic.isValid('1234');             // false

// Formatting
PkCnic.format('4210112345678');     // '42101-1234567-8'
PkCnic.unformat('42101-1234567-8'); // '4210112345678'

// Province & gender
PkCnic.getProvince('42101-1234567-8'); // 'Sindh'
PkCnic.getGender('42101-1234567-8');   // 'Female'  (even last digit)
PkCnic.getGender('42101-1234567-3');   // 'Male'    (odd last digit)

// Extensions
'42101-1234567-8'.isValidPkCnic;   // true
'42101-1234567-8'.pkCnicProvince;  // 'Sindh'
'4210112345678'.formatPkCnic;      // '42101-1234567-8'
```

**Province map:**

| First digit | Province          |
|-------------|-------------------|
| 1           | KPK               |
| 2           | FATA              |
| 3           | Punjab            |
| 4           | Sindh             |
| 5           | Balochistan       |
| 6           | Islamabad         |
| 7           | AJK               |
| 8           | Gilgit-Baltistan  |

---

### 📱 Mobile Numbers

```dart
// All of these are valid input formats
PkMobile.isValid('03001234567');      // true
PkMobile.isValid('+923001234567');    // true
PkMobile.isValid('923001234567');     // true
PkMobile.isValid('3001234567');       // true
PkMobile.isValid('0092 300 1234567'); // true

// Format conversion
PkMobile.format('03001234567');          // '+92 300 1234567'
PkMobile.toInternational('03001234567'); // '+923001234567'
PkMobile.toLocal('+923001234567');       // '03001234567'

// Network detection
PkMobile.getNetwork('03001234567'); // 'Jazz'
PkMobile.getNetwork('03101234567'); // 'Zong'
PkMobile.getNetwork('03301234567'); // 'Ufone'
PkMobile.getNetwork('03401234567'); // 'Telenor'
PkMobile.getNetwork('03551234567'); // 'SCOM'

// Extensions
'03001234567'.isValidPkMobile;  // true
'03001234567'.pkMobileNetwork;  // 'Jazz'
'03001234567'.formatPkMobile;   // '+92 300 1234567'
```

**Network prefix map:**

| Prefix range | Network       |
|--------------|---------------|
| 0300–0309    | Jazz          |
| 0310–0319    | Zong          |
| 0320–0325    | Warid (Jazz)  |
| 0330–0337    | Ufone         |
| 0340–0349    | Telenor       |
| 0355         | SCOM          |

---

### 🏦 IBAN

```dart
// Validation (includes ISO 13616 mod-97 checksum)
PkIban.isValid('PK36SCBL0000001123456702');       // true
PkIban.isValid('PK36 SCBL 0000 0011 2345 6702');  // true  (spaces ok)
PkIban.isValid('PK00SCBL0000001123456702');        // false (bad checksum)

// Formatting
PkIban.format('PK36SCBL0000001123456702');
// 'PK36 SCBL 0000 0011 2345 6702'

// Bank code
PkIban.getBankCode('PK36SCBL0000001123456702'); // 'SCBL'

// Extensions
'PK36SCBL0000001123456702'.isValidPkIban;  // true
'PK36SCBL0000001123456702'.formatPkIban;   // 'PK36 SCBL 0000 0011 2345 6702'
```

---

## 🔌 Full API Reference

### `PkCnic`

| Method | Signature | Description |
|--------|-----------|-------------|
| `isValid` | `(String) → bool` | Validates format & digit count |
| `format` | `(String) → String` | Returns `XXXXX-XXXXXXX-X` |
| `unformat` | `(String) → String` | Strips dashes → 13 raw digits |
| `getProvince` | `(String) → String?` | Province from first digit |
| `getGender` | `(String) → String?` | `'Male'` / `'Female'` from last digit |

### `PkMobile`

| Method | Signature | Description |
|--------|-----------|-------------|
| `isValid` | `(String) → bool` | Validates any Pakistani mobile format |
| `format` | `(String) → String` | Returns `+92 300 1234567` |
| `toInternational` | `(String) → String` | Returns `+923001234567` |
| `toLocal` | `(String) → String` | Returns `03001234567` |
| `getNetwork` | `(String) → String?` | Network operator name |

### `PkIban`

| Method | Signature | Description |
|--------|-----------|-------------|
| `isValid` | `(String) → bool` | Format check + mod-97 checksum |
| `format` | `(String) → String` | Groups of 4 with spaces |
| `getBankCode` | `(String) → String?` | 4-letter bank code |

### `PkValidatorsStringX` (extension on `String`)

| Getter | Type | Description |
|--------|------|-------------|
| `isValidPkCnic` | `bool` | CNIC validity |
| `isValidPkMobile` | `bool` | Mobile validity |
| `isValidPkIban` | `bool` | IBAN validity |
| `formatPkCnic` | `String` | CNIC in `XXXXX-XXXXXXX-X` |
| `formatPkMobile` | `String` | Mobile in `+92 300 XXXXXXX` |
| `formatPkIban` | `String` | IBAN in groups of 4 |
| `pkMobileNetwork` | `String?` | Network operator |
| `pkCnicProvince` | `String?` | Province name |

---

## 🤝 Contributing

Pull requests are welcome! Please open an issue first for significant changes.

1. Fork the repo
2. Create your branch: `git checkout -b feat/my-feature`
3. Run tests: `dart test`
4. Check analysis: `dart analyze`
5. Submit PR

---

## 👨‍💻 Authors

Built with ❤️ for the Pakistani Flutter community.

| | Name | GitHub |
|--|------|--------|
| 👤 | **Mustafa Shahzad** | [@mustafashahzadd](https://github.com/mustafashahzadd) |
| 👤 | **Abu Bakar** | — |

---

## 📄 License

MIT © [Mustafa Shahzad](https://github.com/mustafashahzadd) and Abu Bakar
