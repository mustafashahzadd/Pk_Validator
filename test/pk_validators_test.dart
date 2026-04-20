import 'package:pk_validators/pk_validators.dart';
import 'package:test/test.dart';

void main() {
  // ---------------------------------------------------------------------------
  // CNIC
  // ---------------------------------------------------------------------------
  group('PkCnic.isValid', () {
    test('accepts formatted CNIC', () {
      expect(PkCnic.isValid('42101-1234567-8'), isTrue);
      expect(PkCnic.isValid('35202-3456789-1'), isTrue);
      expect(PkCnic.isValid('61101-9876543-2'), isTrue);
      expect(PkCnic.isValid('11101-1111111-1'), isTrue);
      expect(PkCnic.isValid('54400-0000001-3'), isTrue);
    });

    test('accepts unformatted CNIC', () {
      expect(PkCnic.isValid('4210112345678'), isTrue);
      expect(PkCnic.isValid('3520234567891'), isTrue);
    });

    test('rejects invalid CNICs', () {
      expect(PkCnic.isValid(''), isFalse);
      expect(PkCnic.isValid('1234'), isFalse);
      expect(PkCnic.isValid('ABCDE-1234567-1'), isFalse);
      expect(PkCnic.isValid('42101-12345678-1'), isFalse);
      expect(PkCnic.isValid('42101-123456-1'), isFalse);
      expect(PkCnic.isValid('421011234567'), isFalse);
    });
  });

  group('PkCnic.format', () {
    test('formats raw digits', () {
      expect(PkCnic.format('4210112345678'), '42101-1234567-8');
    });

    test('re-formats already-formatted CNIC', () {
      expect(PkCnic.format('42101-1234567-8'), '42101-1234567-8');
    });

    test('throws on invalid input', () {
      expect(() => PkCnic.format('1234'), throwsFormatException);
    });
  });

  group('PkCnic.unformat', () {
    test('strips dashes', () {
      expect(PkCnic.unformat('42101-1234567-8'), '4210112345678');
    });

    test('returns unchanged raw', () {
      expect(PkCnic.unformat('4210112345678'), '4210112345678');
    });
  });

  group('PkCnic.getProvince', () {
    test('detects all 8 provinces', () {
      expect(PkCnic.getProvince('11101-1234567-1'), 'KPK');
      expect(PkCnic.getProvince('21101-1234567-1'), 'FATA');
      expect(PkCnic.getProvince('31101-1234567-1'), 'Punjab');
      expect(PkCnic.getProvince('42101-1234567-8'), 'Sindh');
      expect(PkCnic.getProvince('51101-1234567-1'), 'Balochistan');
      expect(PkCnic.getProvince('61101-1234567-1'), 'Islamabad');
      expect(PkCnic.getProvince('71101-1234567-1'), 'AJK');
      expect(PkCnic.getProvince('81101-1234567-1'), 'Gilgit-Baltistan');
    });

    test('returns null for invalid CNIC', () {
      expect(PkCnic.getProvince('bad'), isNull);
    });
  });

  group('PkCnic.getGender', () {
    test('odd last digit is Male', () {
      expect(PkCnic.getGender('42101-1234567-1'), 'Male');
      expect(PkCnic.getGender('42101-1234567-3'), 'Male');
      expect(PkCnic.getGender('42101-1234567-9'), 'Male');
    });

    test('even last digit is Female', () {
      expect(PkCnic.getGender('42101-1234567-8'), 'Female');
      expect(PkCnic.getGender('42101-1234567-2'), 'Female');
      expect(PkCnic.getGender('42101-1234567-0'), 'Female');
    });

    test('returns null for invalid CNIC', () {
      expect(PkCnic.getGender('bad'), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // Mobile
  // ---------------------------------------------------------------------------
  group('PkMobile.isValid', () {
    test('accepts all input formats', () {
      expect(PkMobile.isValid('03001234567'), isTrue);
      expect(PkMobile.isValid('3001234567'), isTrue);
      expect(PkMobile.isValid('+923001234567'), isTrue);
      expect(PkMobile.isValid('923001234567'), isTrue);
      expect(PkMobile.isValid('0092 300 1234567'), isTrue);
    });

    test('rejects invalid numbers', () {
      expect(PkMobile.isValid(''), isFalse);
      expect(PkMobile.isValid('12345'), isFalse);
      expect(PkMobile.isValid('0200 1234567'), isFalse);
    });
  });

  group('PkMobile.format', () {
    test('returns readable format', () {
      expect(PkMobile.format('03001234567'), '+92 300 1234567');
      expect(PkMobile.format('+923001234567'), '+92 300 1234567');
    });

    test('throws on invalid', () {
      expect(() => PkMobile.format('bad'), throwsFormatException);
    });
  });

  group('PkMobile.toInternational', () {
    test('returns E.164 format', () {
      expect(PkMobile.toInternational('03001234567'), '+923001234567');
    });
  });

  group('PkMobile.toLocal', () {
    test('returns local 11-digit format', () {
      expect(PkMobile.toLocal('+923001234567'), '03001234567');
      expect(PkMobile.toLocal('923001234567'), '03001234567');
    });
  });

  group('PkMobile.getNetwork', () {
    test('detects Jazz', () {
      expect(PkMobile.getNetwork('03001234567'), 'Jazz');
      expect(PkMobile.getNetwork('03091234567'), 'Jazz');
    });

    test('detects Zong', () {
      expect(PkMobile.getNetwork('03101234567'), 'Zong');
      expect(PkMobile.getNetwork('03191234567'), 'Zong');
    });

    test('detects Warid (Jazz)', () {
      expect(PkMobile.getNetwork('03201234567'), 'Warid (Jazz)');
      expect(PkMobile.getNetwork('03251234567'), 'Warid (Jazz)');
    });

    test('detects Ufone', () {
      expect(PkMobile.getNetwork('03301234567'), 'Ufone');
      expect(PkMobile.getNetwork('03371234567'), 'Ufone');
    });

    test('detects Telenor', () {
      expect(PkMobile.getNetwork('03401234567'), 'Telenor');
      expect(PkMobile.getNetwork('03491234567'), 'Telenor');
    });

    test('detects SCOM', () {
      expect(PkMobile.getNetwork('03551234567'), 'SCOM');
    });

    test('returns null for invalid number', () {
      expect(PkMobile.getNetwork('bad'), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // IBAN
  // ---------------------------------------------------------------------------
  group('PkIban.isValid', () {
    test('accepts valid IBAN', () {
      expect(PkIban.isValid('PK36SCBL0000001123456702'), isTrue);
      expect(PkIban.isValid('PK36 SCBL 0000 0011 2345 6702'), isTrue);
    });

    test('rejects wrong checksum', () {
      expect(PkIban.isValid('PK00SCBL0000001123456702'), isFalse);
      expect(PkIban.isValid('PK99SCBL0000001123456702'), isFalse);
    });

    test('rejects wrong format', () {
      expect(PkIban.isValid(''), isFalse);
      expect(PkIban.isValid('GB36SCBL0000001123456702'), isFalse);
      expect(PkIban.isValid('PK361234567890123456'), isFalse);
    });
  });

  group('PkIban.format', () {
    test('groups in 4s', () {
      expect(
        PkIban.format('PK36SCBL0000001123456702'),
        'PK36 SCBL 0000 0011 2345 6702',
      );
    });

    test('throws on invalid', () {
      expect(() => PkIban.format('bad'), throwsFormatException);
    });
  });

  group('PkIban.getBankCode', () {
    test('extracts bank code', () {
      expect(PkIban.getBankCode('PK36SCBL0000001123456702'), 'SCBL');
    });

    test('returns null for invalid', () {
      expect(PkIban.getBankCode('bad'), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // String extensions
  // ---------------------------------------------------------------------------
  group('PkValidatorsStringX', () {
    test('isValidPkCnic', () {
      expect('42101-1234567-8'.isValidPkCnic, isTrue);
      expect('bad'.isValidPkCnic, isFalse);
    });

    test('isValidPkMobile', () {
      expect('03001234567'.isValidPkMobile, isTrue);
      expect('bad'.isValidPkMobile, isFalse);
    });

    test('isValidPkIban', () {
      expect('PK36SCBL0000001123456702'.isValidPkIban, isTrue);
      expect('bad'.isValidPkIban, isFalse);
    });

    test('formatPkCnic', () {
      expect('4210112345678'.formatPkCnic, '42101-1234567-8');
    });

    test('formatPkMobile', () {
      expect('03001234567'.formatPkMobile, '+92 300 1234567');
    });

    test('formatPkIban', () {
      expect(
        'PK36SCBL0000001123456702'.formatPkIban,
        'PK36 SCBL 0000 0011 2345 6702',
      );
    });

    test('pkMobileNetwork', () {
      expect('03001234567'.pkMobileNetwork, 'Jazz');
      expect('bad'.pkMobileNetwork, isNull);
    });

    test('pkCnicProvince', () {
      expect('42101-1234567-8'.pkCnicProvince, 'Sindh');
      expect('bad'.pkCnicProvince, isNull);
    });
  });
}
