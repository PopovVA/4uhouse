import '../api.dart' show Api;
import 'constants/url.dart' show GUEST_URL, USER_URL;

class UserData extends Api {
  String getUrl(String token, String route) {
    final String context = route.replaceFirst('user/', '');
    return isTokenFormat(token) ? '$USER_URL$context' : '$GUEST_URL$context';
  }
}
