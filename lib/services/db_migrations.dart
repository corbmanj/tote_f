import 'package:tote_f/services/migrations/version3.dart';
import 'package:tote_f/services/migrations/version4.dart';

final Map<int, Function> migrations = {
  3: version3,
  4: version4,
};