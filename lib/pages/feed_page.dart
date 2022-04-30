import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_me/features/geo_post/database/geo_post_database_provider.dart';
import 'package:geo_me/pages/account_page.dart';

import '../features/timestamp/timestamp_conversion.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.read(databaseProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        elevation: 20,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
        ),
        title: const Text('Geo Feed'),
        actions: [
          CupertinoButton(
            child: const Icon(CupertinoIcons.person_crop_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountPage()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: database.allGeoPost,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CupertinoActivityIndicator(
                  radius: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ); // Show a CircularProgressIndicator when the stream is loading
            }
            if (snapshot.error != null) {
              return const Center(
                child: Text('Some error occurred'),
              ); // Show an error just in case(no internet etc)
            }
            return GeoPostList(geoPostList: snapshot.data?.docs);
          },
        ),
      ),
    );
  }
}

class GeoPostList extends ConsumerWidget {
  const GeoPostList({
    Key? key,
    required this.geoPostList,
  }) : super(key: key);

  final List<QueryDocumentSnapshot> geoPostList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.read(databaseProvider);
    return geoPostList.isNotEmpty
        ? ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final _currentGeoPost = geoPostList[index];
              return Card(
                  elevation: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _currentGeoPost['username'], //+
                          //  readTimestamp(_currentGeoPost['postedat']),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (_currentGeoPost['geolocation'].longitude.toInt() < 0)
                              ? "Longitude: " +
                                  _currentGeoPost['geolocation']
                                      .longitude
                                      .toInt()
                                      .abs()
                                      .toString() +
                                  "° W"
                              : "Longitude: " +
                                  _currentGeoPost['geolocation']
                                      .longitude
                                      .toString() +
                                  "° E",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (_currentGeoPost['geolocation'].latitude.toInt() < 0)
                              ? "Latitude: " +
                                  _currentGeoPost['geolocation']
                                      .latitude
                                      .toInt()
                                      .abs()
                                      .toString() +
                                  "° N"
                              : "Longitude: " +
                                  _currentGeoPost['geolocation']
                                      .latitude
                                      .toInt()
                                      .toString() +
                                  "° S",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _currentGeoPost['description'],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Posted " +
                              readTimestamp(_currentGeoPost['postedat']),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 10,
            ),
            itemCount: geoPostList.length,
          )
        : const Center(child: Text('No GeoPost yet'));
  }
}
