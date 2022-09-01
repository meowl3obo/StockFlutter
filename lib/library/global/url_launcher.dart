import 'package:url_launcher/url_launcher.dart';

Future<void> openPage(String url) async {
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw "Could not lauunch $url";
  }
}