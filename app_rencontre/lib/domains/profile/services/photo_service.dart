import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nocturne/shared/services/api_service.dart';

/// Each uploaded photo is classified server-side before it's visible to
/// anyone: [approved] photos are already on the profile, [pendingCount]
/// went to the moderation queue, [rejectedCount] were refused outright.
class PhotoUploadResult {
    final List<String> approved;
    final int pendingCount;
    final int rejectedCount;
    const PhotoUploadResult({
        required this.approved,
        required this.pendingCount,
        required this.rejectedCount,
    });
}

class PhotoService {
    static Future<PhotoUploadResult> uploadPhotos(List<String> paths) async {
        final token = await ApiService.getToken();
        final uri = Uri.parse('${ApiService.baseUrl}/profile/photos');
        final request = http.MultipartRequest('POST', uri);
        request.headers['Authorization'] = 'Bearer $token';

        for (final path in paths) {
            request.files.add(await http.MultipartFile.fromPath('photos', path));
        }

        final response = await request.send();
        final body = await response.stream.bytesToString();
        final data = jsonDecode(body);
        return PhotoUploadResult(
            approved:      List<String>.from(data['approved']),
            pendingCount:  data['pendingCount'] as int? ?? 0,
            rejectedCount: data['rejectedCount'] as int? ?? 0,
        );
    }
}