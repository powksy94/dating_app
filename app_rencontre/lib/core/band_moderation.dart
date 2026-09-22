import 'package:flutter/scheduler.dart';
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

void _loadWordLists() {
  if (SafeTextFilter.isInitialized) return;
  SafeTextFilter.init(languages: [Language.english, Language.french]);
}

/// Warms the English and French word lists up during idle time (never while
/// a frame is busy, e.g. mid-animation), so the first real check is already
/// paid for by the time it happens. Call this once when the field appears.
/// Safe to call more than once: a pending or finished load is a no-op.
void prepareBandModeration() {
  if (SafeTextFilter.isInitialized) return;
  SchedulerBinding.instance.scheduleTask(_loadWordLists, Priority.idle);
}

/// True when [name] contains a link, a handle or an insult.
bool isBandNameRefused(String name) {
  if (_linkPattern.hasMatch(name)) return true;
  // The idle warm-up above may not have run yet (e.g. a very fast typer): this
  // blocks instead of skipping the check, moderation is never bypassed to stay fast.
  _loadWordLists();
  return SafeTextFilter.containsBadWord(
    text: name,
    excludedWords: _allowedInBandNames,
  );
}
