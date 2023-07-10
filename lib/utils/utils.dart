import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  // static String apiUrl = "http://192.168.1.8:5001";
  static String apiUrl = "https://hanoi-foodtour-api.vercel.app";

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

  static Future<void> openMap(double latitude, double longitude) async {
    String appleUrl = 'https://maps.apple.com/?saddr=&daddr=$latitude,$longitude&directionsmode=driving';
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';


    if (Platform.isIOS) {
      if (await canLaunch(appleUrl)) {
        await launch(appleUrl);
      } else {
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        } else {
          throw 'Could not open the map.';
        }
      }
    } else {
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
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
