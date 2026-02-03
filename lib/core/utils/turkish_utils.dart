/// Turkish character normalization for email/ASCII-only use (e.g. altinbas.edu.tr).
/// Display names must always use original UTF-8 strings.
const Map<String, String> _trToAscii = {
  'ç': 'c', 'ğ': 'g', 'ı': 'i', 'ö': 'o', 'ş': 's', 'ü': 'u',
  'Ç': 'c', 'Ğ': 'g', 'İ': 'i', 'Ö': 'o', 'Ş': 's', 'Ü': 'u',
};

String turkishToAsciiLowerCase(String text) {
  if (text.isEmpty) return text;
  final buffer = StringBuffer();
  for (final rune in text.runes) {
    final char = String.fromCharCode(rune);
    buffer.write(_trToAscii[char] ?? char.toLowerCase());
  }
  return buffer.toString();
}
