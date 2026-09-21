import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/chat/models/starter_suggestion.dart';

/// Builds the texts of a conversation starter from the ids the server sends. All
/// sentences live in app_fr.arb / app_en.arb; an id this build does not know
/// (a template added on the server before this version) gives null and is skipped.
typedef _Text = String? Function(AppLocalizations l, StarterSuggestion s);

// A template whose value is missing is unusable: null, so it is skipped too.
String? _with(String? value, String Function(String) build) => value == null ? null : build(value);

final Map<String, _Text> _hooks = {
  'hook_shared':     (l, s) => _with(s.tag,   l.starterHookShared),
  'hook_rare':       (l, s) => _with(s.tag,   l.starterHookRare),
  'hook_combo':      (l, s) => s.tag == null || s.tag2 == null ? null : l.starterHookCombo(s.tag!, s.tag2!),
  'hook_band':       (l, s) => _with(s.band,  l.starterHookBand),
  'hook_event':      (l, s) => _with(s.event, l.starterHookEvent),
  'hook_mood':       (l, s) => l.starterHookMood,
  'hook_other_band': (l, s) => _with(s.band,  l.starterHookOtherBand),
};

final Map<String, _Text> _messages = {
  'genre_1':            (l, s) => _with(s.tag,  l.starterMsgGenre1),
  'genre_2':            (l, s) => _with(s.tag,  l.starterMsgGenre2),
  'genre_3':            (l, s) => _with(s.tag,  l.starterMsgGenre3),
  'vibe_1':             (l, s) => _with(s.tag,  l.starterMsgVibe1),
  'vibe_2':             (l, s) => _with(s.tag,  l.starterMsgVibe2),
  'vibe_sensitive':     (l, s) => l.starterMsgVibeSensitive,
  'aesthetic_1':        (l, s) => _with(s.tag,  l.starterMsgAesthetic1),
  'intensity_1':        (l, s) => _with(s.tag,  l.starterMsgIntensity1),
  'era_1':              (l, s) => _with(s.tag,  l.starterMsgEra1),
  'format_concerts':    (l, s) => l.starterMsgFormatConcerts,
  'format_vinyl':       (l, s) => l.starterMsgFormatVinyl,
  'format_bandcamp':    (l, s) => l.starterMsgFormatBandcamp,
  'format_playlist':    (l, s) => l.starterMsgFormatPlaylist,
  'format_underground': (l, s) => l.starterMsgFormatUnderground,
  'band_1':             (l, s) => _with(s.band, l.starterMsgBand1),
  'event_1':            (l, s) => l.starterMsgEvent1,
  'other_band_1':       (l, s) => _with(s.band, l.starterMsgOtherBand1),
  'combo_1':            (l, s) => s.tag == null || s.tag2 == null ? null : l.starterMsgCombo1(s.tag!, s.tag2!),
};

/// A suggestion ready to display: the banner in the app's voice and the message
/// sent, in the first person, to the other person.
class StarterText {
  final String? banner;
  final String  message;
  const StarterText({this.banner, required this.message});
}

/// Null when this build cannot write the suggestion.
StarterText? starterText(AppLocalizations l, StarterSuggestion s) {
  final hook    = _hooks[s.hook]?.call(l, s);
  final message = _messages[s.message]?.call(l, s);
  if (hook == null || message == null) return null;
  return StarterText(banner: hook, message: message);
}

/// The classic icebreakers: used when nothing is in common, and behind the toggle.
List<StarterText> classicStarterTexts(AppLocalizations l) => [
      l.starterFallback1,
      l.starterFallback2,
      l.starterFallback3,
      l.starterFallback4,
      l.starterFallback5,
      l.starterFallback6,
    ].map((message) => StarterText(message: message)).toList();
