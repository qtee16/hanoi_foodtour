import 'dart:convert';
import 'dart:io';

class Utils {
  static String apiUrl = "http://192.168.1.7:5001";
  // static String apiUrl = "https://hanoi-foodtour-api.vercel.app";

  static Future<String> encodeImage(File image) async {
    final imageBytes = await image.readAsBytes();
    final imageEncode = base64.encode(imageBytes);
    return imageEncode;
  }
}
