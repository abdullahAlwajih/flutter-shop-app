import 'package:super_repository/app/models/base_model.dart';

class User extends BaseModel {
  String? token;
  String? email;
  String? emailVerified;
  String? refreshToken;
  String? expiresIn;
  String? userID;
  bool? registered;
  String? federatedId;
  String? providerId;
  String? oauthIdToken;
  String? fullName;
  String? displayName;
  String? photoUrl;

  User({
    this.token,
    this.email,
    this.emailVerified,
    this.refreshToken,
    this.expiresIn,
    this.userID,
    this.registered,
    this.federatedId,
    this.providerId,
    this.oauthIdToken,
    this.fullName,
    this.displayName,
    this.photoUrl,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
        token: map['idToken'] as String?,
        email: map['email'] as String?,
        refreshToken: map['refreshToken'] as String?,
        expiresIn: map['expiresIn'],
        registered: map['registered'] as bool?,
        emailVerified: map['emailVerified'] as String?,
        userID: map['userID'] as String?,
        federatedId: map['federatedId'] as String?,
        providerId: map['providerId'] as String?,
        oauthIdToken: map['oauthIdToken'] as String?,
        fullName: map['fullName'] as String?,
        displayName: map['displayName'] as String?,
        photoUrl: map['photoUrl'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'idToken': token,
        'email': email,
        'emailVerified': emailVerified,
        'refreshToken': refreshToken,
        'expiresIn': expiresIn,
        'userID': userID,
        'registered': registered,
        'federatedId': federatedId,
        'providerId': providerId,
        'oauthIdToken': oauthIdToken,
        'fullName': fullName,
        'displayName': displayName,
        'photoUrl': photoUrl,
      };

  static Map<String, dynamic> toSignUp(email, password) => {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      };

  DateTime getExpiresDate() =>
      DateTime.now().add(Duration(seconds: int.parse(expiresIn ?? '0')));


  @override
  BaseModel fromJson(Map<String, dynamic> json) => User.fromMap(json);

  @override
  Map<String, dynamic> toJson() => toMap();

  @override
  List<BaseModel> fromJsonList(List json) => [];


}
