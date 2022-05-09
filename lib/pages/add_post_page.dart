import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_me/features/geo_post/model/geo_post_model.dart';

import '../features/geo_post/database/geo_post_database_provider.dart';
import 'feed_page.dart';

class AddPostPage extends ConsumerWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _descriptionController = TextEditingController();
    return Scaffold(
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
        title: const Text('Add a Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Theme.of(context).colorScheme.primaryContainer,
              textColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () async {
                final response = ref.read(databaseProvider);
                try {
                  GeoPost _geopost = GeoPost(
                    postedAt: Timestamp.fromDate(DateTime.now()),
                    geolocation: const GeoPoint(22, 99),
                    description: _descriptionController.text,
                    likes: 0,
                    username:
                        FirebaseAuth.instance.currentUser!.email.toString(),
                  );
                  await response.addNewPost(_geopost, context);
                } catch (e) {
                  await showDialog(
                    context: context,
                    builder: (ctx) => CupertinoAlertDialog(
                      title: const Text('Error Occured'),
                      content: Text(e.toString()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FeedPage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text("OK"),
                        )
                      ],
                    ),
                  );
                }
              },
              child: const Text("POST"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Placeholder(
              fallbackHeight: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TextField(
                controller: _descriptionController,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Description',
                ),
                minLines: 1,
                maxLines: null,
                expands:
                    false, // If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the parent.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
