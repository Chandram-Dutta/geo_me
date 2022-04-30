import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'geo_post_database.dart';

final databaseProvider = Provider(
  (ref) => GeoPostDatabase(),
);
