abstract class AppUrls {
  static const String apiKEY = 'AIzaSyDcT8yCIoPqZoVtBTqOKMQFs44xpgpO6n8';
  static const String baseUrlFirebase =
      'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const String signUp = '${baseUrlFirebase}signUp?key=$apiKEY';
  static const String signInWithPassword =
      '${baseUrlFirebase}signInWithPassword?key=$apiKEY';
  static const String signInWithCustomToken =
      '${baseUrlFirebase}signInWithCustomToken?key=$apiKEY';
  static const String signInWithIdp =
      '${baseUrlFirebase}signInWithIdp?key=$apiKEY';
  static const String createAuthUri =
      '${baseUrlFirebase}createAuthUri?key=$apiKEY';
  static const String sendOobCode = '${baseUrlFirebase}sendOobCode?key=$apiKEY';
  static const String resetPassword =
      '${baseUrlFirebase}resetPassword?key=$apiKEY';
  static const String update = '${baseUrlFirebase}update?key=$apiKEY';
  static const String lookup = '${baseUrlFirebase}lookup?key=$apiKEY';

  static const String baseUrl =
      'https://flutter-shop-app-117db-default-rtdb.firebaseio.com/';
  static const String products = '${baseUrl}products';
  static const String userFavorites = '${baseUrl}userFavorites';
  static const String orders = '${baseUrl}orders';
}
