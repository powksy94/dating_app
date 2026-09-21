/// One conversation starter as the server describes it: template ids and the
/// values to put in them, never a sentence. The texts are built in the app from
/// its own translations (see starter_texts.dart).
class StarterSuggestion {
  final String  hook;
  final String  message;
  final String? tag;
  final String? tag2;
  final String? band;
  final String? event;

  const StarterSuggestion({
    required this.hook,
    required this.message,
    this.tag,
    this.tag2,
    this.band,
    this.event,
  });

  factory StarterSuggestion.fromJson(Map<String, dynamic> json) => StarterSuggestion(
        hook:    json['hook']    as String? ?? '',
        message: json['message'] as String? ?? '',
        tag:     json['tag']     as String?,
        tag2:    json['tag2']    as String?,
        band:    json['band']    as String?,
        event:   json['event']   as String?,
      );
}

class StarterSuggestions {
  /// False when the two profiles share nothing: the reassurance dialog is shown.
  final bool hasCommon;

  /// "common", "other_band" or "none" ("none" means only classic icebreakers).
  final String source;
  final List<StarterSuggestion> suggestions;

  const StarterSuggestions({
    required this.hasCommon,
    required this.source,
    required this.suggestions,
  });

  factory StarterSuggestions.fromJson(Map<String, dynamic> json) => StarterSuggestions(
        hasCommon: json['hasCommon'] as bool? ?? false,
        source:    json['source']    as String? ?? 'none',
        suggestions: (json['suggestions'] as List? ?? const [])
            .map((e) => StarterSuggestion.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
