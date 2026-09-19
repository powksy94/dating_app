import 'package:safe_text/safe_text.dart';

/// Words from the profanity lists that are everyday material in dark music band
/// names (Sex Pistols, Killing Joke, Massive Attack, Rotting Christ...). They
/// are themes, not insults, so they stay allowed in a band name.
const _allowedInBandNames = [
  'sex', 'suicide', 'kill', 'killing', 'attack', 'assassin',
  'pistol', 'sodom', 'christ', 'napalm', 'damned', 'bloody',
];

// A band name can end up in a message sent under another user's name, so
// links and handles are refused too.
final _linkPattern = RegExp(r'(https?:|www\.|://|@)', caseSensitive: false);

/// Loads the English and French word lists. Call it early (for example when the
/// field appears) so the first check does not pay for building them.
void prepareBandModeration() {
  if (SafeTextFilter.isInitialized) return;
  SafeTextFilter.init(languages: [Language.english, Language.french]);
}

/// True when [name] contains a link, a handle or an insult.
bool isBandNameRefused(String name) {
  if (_linkPattern.hasMatch(name)) return true;
  prepareBandModeration();
  return SafeTextFilter.containsBadWord(
    text: name,
    excludedWords: _allowedInBandNames,
  );
}
