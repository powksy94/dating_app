import 'package:flutter/material.dart';

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

IconData socialPlatformIcon(String platform) {
  switch (platform.toLowerCase()) {
    case 'instagram': return Icons.camera_alt;
    case 'spotify':   return Icons.graphic_eq;
    case 'bandcamp':  return Icons.music_note;
    case 'lastfm':    return Icons.bar_chart;
    case 'tumblr':    return Icons.dashboard;
    case 'discord':   return Icons.forum;
    default:          return Icons.link;
  }
}
