import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/trip.dart';

part 'trip_provider.g.dart';

@riverpod
class TripNotifier extends _$TripNotifier {
  @override
  Trip build() {
    return Trip(
      city: 'Austin',
      days: [],
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );
  }

  void loadTrip(Trip trip) {
    // final Trip newTrip = Trip(
    //   city: trip.city,
    //   days: trip.days,
    //   startDate: trip.startDate,
    //   endDate: trip.endDate,
    // );
    final Trip newTrip = state.copyWith(
        city: trip.city,
        days: trip.days,
        startDate: trip.startDate,
        endDate: trip.endDate);
    print('${newTrip.city}, ${newTrip.days.length}');
    state = newTrip;
  }
}
