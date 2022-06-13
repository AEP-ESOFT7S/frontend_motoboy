import 'dart:convert';

class IFoodCredentials {
  String clientId;
  String clientSecret;

  IFoodCredentials({
    required this.clientId,
    required this.clientSecret,
  });

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'clientSecret': clientSecret,
    };
  }

  factory IFoodCredentials.fromMap(Map<String, dynamic> map) {
    return IFoodCredentials(
      clientId: map['clientId'] ?? '',
      clientSecret: map['clientSecret'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IFoodCredentials.fromJson(String source) => IFoodCredentials.fromMap(json.decode(source));
}
