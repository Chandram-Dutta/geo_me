import 'package:cloud_firestore/cloud_firestore.dart';

class GeoPost {
  String description;
  String username;
  GeoPoint geolocation;

  Timestamp postedAt;
  int likes;

  GeoPost({
    required this.geolocation,
    required this.description,
    required this.likes,
    required this.username,
    required this.postedAt,
  });
}
