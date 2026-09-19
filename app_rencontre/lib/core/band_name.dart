/// Comparison key for a band name typed by a user. Case, accents, punctuation,
/// repeated spaces and a leading "the" are ignored, so "The Cure", "the  cure"
/// and "Cure" all give the same key. Letters of any script are kept, so names
/// written in other alphabets are compared as they are.
String bandKey(String name) {
  final folded = StringBuffer();
  for (final rune in name.toLowerCase().runes) {
    final char = String.fromCharCode(rune);
    folded.write(_accentFolding[char] ?? char);
  }
  var key = folded
      .toString()
      .replaceAll(RegExp(r'[̀-ͯ]'), '')
      .replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  if (key.startsWith('the ')) key = key.substring(4);
  return key;
}

/// True when [candidate] is the same band as one already in [bands].
bool containsBand(Iterable<String> bands, String candidate) {
  final key = bandKey(candidate);
  return bands.any((band) => bandKey(band) == key);
}

const _accentFolding = {
  'à': 'a', 'á': 'a', 'â': 'a', 'ä': 'a', 'ã': 'a', 'å': 'a',
  'ç': 'c',
  'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e',
  'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i',
  'ñ': 'n',
  'ò': 'o', 'ó': 'o', 'ô': 'o', 'ö': 'o', 'õ': 'o', 'ø': 'o',
  'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u',
  'ý': 'y', 'ÿ': 'y',
  'œ': 'oe', 'æ': 'ae', 'ß': 'ss',
};
