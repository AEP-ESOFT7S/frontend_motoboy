import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WaypointsResponse {
  double distance;
  String name;
  double longitude;
  double latitude;

  WaypointsResponse({
    required this.distance,
    required this.name,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'distance': distance,
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory WaypointsResponse.fromMap(Map<String, dynamic> map) {
    return WaypointsResponse(
      distance: map['distance'] as double,
      name: map['name'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory WaypointsResponse.fromJson(String source) =>
      WaypointsResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
