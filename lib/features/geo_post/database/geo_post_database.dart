// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_me/features/geo_post/model/geo_post_model.dart';

class GeoPostDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference _geoPostsCollection;
  Stream get allGeoPost => _firestore.collection("geopost").snapshots();

  Future<bool> addNewPost(GeoPost m) async {
    _geoPostsCollection =
        _firestore.collection('geopost'); // referencing the movie collection .
    try {
      await _geoPostsCollection.add({
        'geolocation': m.geolocation,
        'description': m.description,
        'likes': m.likes,
        'username': m.username,
        'postedat': m.postedAt,
      }); // Adding a new document to our movies collection
      return true; // finally return true
    } catch (e) {
      return Future.error(e); // return error
    }
  }

  Future<bool> removeGeoPost(String postId) async {
    _geoPostsCollection = _firestore.collection('geopost');
    try {
      await _geoPostsCollection
          .doc(postId)
          .delete(); // deletes the document with id of movieId from our movies collection
      return true; // return true after successful deletion .
    } catch (e) {
      print(e);
      return Future.error(e); // return error
    }
  }

  Future<bool> likeGeoPost(GeoPost m, String postId) async {
    _geoPostsCollection = _firestore.collection('geopost');
    try {
      await _geoPostsCollection.doc(postId).update(
        // updates the movie document having id of moviedId
        {
          'likes': m.likes + 1,
        },
      );
      return true; //// return true after successful updation .
    } catch (e) {
      print(e);
      return Future.error(e); //return error
    }
  }

  Future<bool> editGeoPost(GeoPost m, String postId) async {
    _geoPostsCollection = _firestore.collection('geopost');
    try {
      await _geoPostsCollection
          .doc(postId)
          .update(// updates the movie document having id of moviedId
              {
        'geolocation': m.geolocation,
        'description': m.description,
        'likes': m.likes,
        'username': m.username,
        'postedat': m.postedAt,
      });
      return true; //// return true after successful updation .
    } catch (e) {
      print(e);
      return Future.error(e); //return error
    }
  }
}
