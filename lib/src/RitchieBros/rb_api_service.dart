import 'dart:convert';
import 'package:http/http.dart' as http;
import 'rb_item.dart';

class RBApiService {
  static const String _baseUrl = 'https://api.marketplace.ritchiebros.com/marketplace-listings-service/v1/api/search';
  
  /// Fetches auction items from the Ritchie Bros API
  /// 
  /// [from] - Starting index for pagination (default: 0)
  /// [size] - Number of items to fetch (default: 20)
  static Future<List<RBItem>> fetchItems({int from = 0, int size = 20}) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'from': from,
          'size': size,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> records = data['records'] ?? [];
        
        return records
            .map((json) => RBItem.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching items: $e');
    }
  }
}
