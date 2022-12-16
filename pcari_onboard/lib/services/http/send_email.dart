
import 'package:pcari_onboard/model/contact.dart';
import 'package:url_launcher/url_launcher.dart';

void sendEmail({
  required Contact contact
}) {
  String uri = 'mailto:${contact.email}?subject=Hello%20${contact.firstName}%20${contact.lastName}!&body=${contact.isFavorite ? 'Great news, you are in my favorite contacts!' : 'Sorry, you are not in my favorite contacts.'}';
  launchUrl(Uri.parse(uri));
}