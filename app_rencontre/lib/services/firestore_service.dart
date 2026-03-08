import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/alternative_profile.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  // ── Profil ──────────────────────────────────────────────────────────────

  Future<AlternativeProfile?> getProfile(String uid) async {
    final doc = await _db.collection('profiles').doc(uid).get();
    if (!doc.exists) return null;
    return AlternativeProfile.fromFirestore(doc);
  }

  Future<void> saveProfile(String uid, Map<String, dynamic> data) =>
      _db.collection('profiles').doc(uid).set(data, SetOptions(merge: true));

  // ── Swipe ────────────────────────────────────────────────────────────────

  /// Charge des profils à swiper (exclut l'utilisateur courant et les déjà vus).
  Future<List<AlternativeProfile>> fetchSwipeProfiles(String currentUid) async {
    final snap = await _db
        .collection('profiles')
        .where(FieldPath.documentId, isNotEqualTo: currentUid)
        .limit(20)
        .get();
    return snap.docs.map(AlternativeProfile.fromFirestore).toList();
  }

  /// Enregistre un like : currentUid → targetUid.
  /// Retourne true si c'est un match (l'autre a déjà liké).
  Future<bool> saveLike(String currentUid, String targetUid) async {
    final batch = _db.batch();

    final likeRef = _db
        .collection('likes')
        .doc(currentUid)
        .collection('liked')
        .doc(targetUid);
    batch.set(likeRef, {'likedAt': FieldValue.serverTimestamp()});

    await batch.commit();

    // Vérifie si l'autre a déjà liké → match
    final reverse = await _db
        .collection('likes')
        .doc(targetUid)
        .collection('liked')
        .doc(currentUid)
        .get();

    return reverse.exists;
  }

  /// Enregistre un dislike : currentUid → targetUid.
  Future<void> saveDislike(String currentUid, String targetUid) =>
      _db
          .collection('dislikes')
          .doc(currentUid)
          .collection('disliked')
          .doc(targetUid)
          .set({'dislikedAt': FieldValue.serverTimestamp()});
}
