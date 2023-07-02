import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';

class Utils {
  static String apiUrl = "http://192.168.1.5:5001";
  // static String apiUrl = "https://hanoi-foodtour-api.vercel.app";

  static Future<String> encodeImage(File image) async {
    final imageBytes = await image.readAsBytes();
    final imageEncode = base64.encode(imageBytes);
    return imageEncode;
  }

  static String convertDateTime(String dateString) {
    final date = DateTime.parse(dateString).toLocal();
    String value = "";
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int day = DateTime.now().day;
    if (date.year != year || date.month != month || date.day != day) {
      value = DateFormat("dd/MM/yyyy").format(date);
    } else {
      value = DateFormat("HH:mm").format(date);
    }
    return value;
  }

  static Map<int, String> categoriesMap = {
    1: "Phở",
    2: "Bún",
    3: "Miến",
    4: "Cơm",
    5: "Cháo",
    6: "Khác"
  };
}
