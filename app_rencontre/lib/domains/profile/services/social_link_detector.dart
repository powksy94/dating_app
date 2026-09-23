import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Mirrors social-links.ts on the server, which has the final say: a link
/// that matches no known platform here but somehow would there (or the
/// reverse) is a bug to fix by keeping the two lists identical, not a case to
/// handle specially.
const _platformHosts = {
  'spotify':   ['open.spotify.com', 'spotify.com'],
  'instagram': ['instagram.com', 'www.instagram.com'],
  'bandcamp':  ['bandcamp.com'],
  'lastfm':    ['last.fm', 'www.last.fm'],
  'tumblr':    ['tumblr.com'],
  // Discord has no universal "view my profile" page: what ends up here is
  // usually a server invite (discord.gg/...), not a personal profile.
  'discord':   ['discord.com', 'discord.gg'],
};

bool _hostMatches(String host, List<String> allowed) =>
    allowed.any((allowedHost) => host == allowedHost || host.endsWith('.$allowedHost'));

/// The platform a URL belongs to, decided by its own domain. Null when it
/// matches none of the platforms the app (and the server) recognize.
String? detectSocialPlatform(String value) {
  final uri = Uri.tryParse(value);
  if (uri == null || uri.scheme != 'https') return null;
  for (final entry in _platformHosts.entries) {
    if (_hostMatches(uri.host, entry.value)) return entry.key;
  }
  return null;
}

/// The platform's real logo (Font Awesome's free brand icons), not a generic
/// stand-in. Render with `FaIcon`, not a plain `Icon`: `FaIconData` isn't an
/// `IconData`, it carries information `Icon` doesn't know how to use.
FaIconData socialPlatformIcon(String platform) {
  switch (platform.toLowerCase()) {
    case 'instagram': return FontAwesomeIcons.instagram;
    case 'spotify':   return FontAwesomeIcons.spotify;
    case 'bandcamp':  return FontAwesomeIcons.bandcamp;
    case 'lastfm':    return FontAwesomeIcons.lastfm;
    case 'tumblr':    return FontAwesomeIcons.tumblr;
    case 'discord':   return FontAwesomeIcons.discord;
    default:          return FontAwesomeIcons.link;
  }
}
