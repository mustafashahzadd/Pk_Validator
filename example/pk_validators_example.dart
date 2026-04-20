// ignore_for_file: avoid_print
import 'package:pk_validators/pk_validators.dart';

void main() {
  // ── CNIC ────────────────────────────────────────────────────────────────────
  print('=== CNIC ===');
  print(PkCnic.isValid('42101-1234567-8')); // true
  print(PkCnic.isValid('4210112345678')); // true
  print(PkCnic.isValid('1234')); // false

  print(PkCnic.format('4210112345678')); // 42101-1234567-8
  print(PkCnic.unformat('42101-1234567-8')); // 4210112345678
  print(PkCnic.getProvince('42101-1234567-8')); // Sindh
  print(PkCnic.getGender('42101-1234567-8')); // Female
  print(PkCnic.getGender('42101-1234567-3')); // Male

  // ── Mobile ──────────────────────────────────────────────────────────────────
  print('\n=== Mobile ===');
  print(PkMobile.isValid('03001234567')); // true
  print(PkMobile.isValid('+923001234567')); // true
  print(PkMobile.isValid('0092 300 1234567')); // true

  print(PkMobile.format('03001234567')); // +92 300 1234567
  print(PkMobile.toInternational('03001234567')); // +923001234567
  print(PkMobile.toLocal('+923001234567')); // 03001234567
  print(PkMobile.getNetwork('03001234567')); // Jazz
  print(PkMobile.getNetwork('03101234567')); // Zong
  print(PkMobile.getNetwork('03301234567')); // Ufone
  print(PkMobile.getNetwork('03401234567')); // Telenor
  print(PkMobile.getNetwork('03551234567')); // SCOM

  // ── IBAN ────────────────────────────────────────────────────────────────────
  print('\n=== IBAN ===');
  print(PkIban.isValid('PK36SCBL0000001123456702')); // true
  print(PkIban.isValid('PK00SCBL0000001123456702')); // false
  print(PkIban.format('PK36SCBL0000001123456702')); // PK36 SCBL 0000 0011 2345 6702
  print(PkIban.getBankCode('PK36SCBL0000001123456702')); // SCBL

  // ── String extensions ───────────────────────────────────────────────────────
  print('\n=== Extensions ===');
  print('42101-1234567-8'.isValidPkCnic); // true
  print('42101-1234567-8'.pkCnicProvince); // Sindh
  print('4210112345678'.formatPkCnic); // 42101-1234567-8

  print('03001234567'.isValidPkMobile); // true
  print('03001234567'.pkMobileNetwork); // Jazz
  print('03001234567'.formatPkMobile); // +92 300 1234567

  print('PK36SCBL0000001123456702'.isValidPkIban); // true
  print('PK36SCBL0000001123456702'.formatPkIban); // PK36 SCBL 0000 0011 2345 6702
}
