import 'package:url_launcher/url_launcher.dart';

class Launcher {
  Launcher._privateController();
  static final instance = Launcher._privateController();

  Future<void> open(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
