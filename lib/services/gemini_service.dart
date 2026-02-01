import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static Future<Map<String, dynamic>> generateTripPlan({
    required String destination,
    required String budget,
    required int days,
    required String people,
    required String travelWith,
  }) async {
    try {
      // Check if dotenv is loaded and get API key
      String? apiKey;
      try {
        apiKey = dotenv.env['GEMINI_API_KEY'];
      } catch (e) {
        // If dotenv is not initialized, try to load it
        try {
          await dotenv.load(fileName: ".env");
          apiKey = dotenv.env['GEMINI_API_KEY'];
        } catch (loadError) {
          throw Exception('Failed to load .env file. Please ensure .env file exists in the root directory with GEMINI_API_KEY=your_api_key');
        }
      }
      
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('GEMINI_API_KEY not found in .env file. Please add GEMINI_API_KEY=your_api_key to your .env file');
      }

      final prompt = '''Create a $days-day travel itinerary for $people people visiting $destination on a $budget budget, tailored for $travelWith.
Use real, famous places and hotels that actually exist in $destination.
Please include 4-5 different hotels with varying price ranges and amenities.

Return a valid JSON object with this structure (ONLY the JSON, no other text):
{
  "places": [
    {
      "name": "Place Name (use real place names in $destination)",
      "time": "2-3 hours",
      "details": "Brief description",
      "coordinates": "Latitude, Longitude",
      "pricing": "Entry fee info",
      "bestTime": "Best time to visit"
    }
  ],
  "hotels": [
    {
      "name": "Hotel Name (use real hotels in $destination)",
      "address": "Real address in $destination",
      "price": "Price range",
      "rating": "4.5/5",
      "amenities": ["Wi-Fi", "Pool"],
      "description": "Brief description"
    }
  ],
  "transportation": ["Transportation option 1"],
  "costs": ["Accommodation: \$X"],
  "itinerary": [{"day": 1, "activities": ["Morning: Activity"]}]
}''';

      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        
        // Extract JSON from the response (in case there's extra text)
        final jsonMatch = RegExp(r'\{[\s\S]*\}').firstMatch(text);
        if (jsonMatch != null) {
          final jsonString = jsonMatch.group(0);
          return jsonDecode(jsonString!);
        } else {
          throw Exception('No valid JSON found in response');
        }
      } else {
        throw Exception('API request failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error generating trip plan: $e');
    }
  }
}

