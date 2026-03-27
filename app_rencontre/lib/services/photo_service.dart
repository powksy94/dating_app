import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_service.dart';

class PhotoService {
    static Future<List<String>> uploadPhotos(List<String> paths) async {
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
        return List<String>.from(data['photos']);
    }
}