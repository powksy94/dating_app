/// A favorite band as stored on a profile: a plain typed name, or one picked
/// from Spotify search (`imageUrl` and `spotifyId` set). Mirrors FavoriteBand
/// on the server (band-name.ts): the server is what actually decides which
/// name/image wins for a given `spotifyId`, this is only the app's shape.
class FavoriteBand {
  final String name;
  final String? imageUrl;
  final String? spotifyId;

  const FavoriteBand({required this.name, this.imageUrl, this.spotifyId});

  factory FavoriteBand.fromJson(dynamic json) {
    // A profile fetched before the migration script ran could still have a
    // plain string here.
    if (json is String) return FavoriteBand(name: json);
    final map = json as Map<String, dynamic>;
    return FavoriteBand(
      name:      map['name'] as String? ?? '',
      imageUrl:  map['imageUrl'] as String?,
      spotifyId: map['spotifyId'] as String?,
    );
  }

  /// What the app sends back. `imageUrl` is never included: for a Spotify
  /// pick, the server looks it up itself from `spotifyId` rather than trust
  /// whatever the client says it is (see sanitizeFavoriteBands).
  Map<String, dynamic> toJson() => {
        'name': name,
        if (spotifyId != null) 'spotifyId': spotifyId,
      };
}
