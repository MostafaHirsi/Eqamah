import 'package:eqamah/utils/keys.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GoogleServices {
  static Future<dynamic> get(int maxWidth, String photoRef) async {
    if(photoRef == null)
    {
      return null;
    }
    final dynamic response = await http.get(
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth&photoreference=$photoRef&key=$API_KEY");
    return response;
  }

  String imageUrlBuilder(int maxWidth, String photoRef) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth&photoreference=$photoRef&key=$API_KEY";
  }
}
