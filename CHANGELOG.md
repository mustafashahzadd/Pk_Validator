## 0.1.0

- Initial release.
- `PkCnic`: validate, format, unformat, province detection, gender detection.
- `PkMobile`: validate all Pakistani number formats, format conversions
  (local / international / readable), network operator detection for Jazz,
  Zong, Warid, Ufone, Telenor, and SCOM.
- `PkIban`: validate with ISO 13616 mod-97 checksum, grouped formatting,
  bank code extraction.
- `PkValidatorsStringX`: ergonomic `String` extension methods for all validators.
- Zero runtime dependencies — pure Dart, all 6 platforms.
