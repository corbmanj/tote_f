import 'package:uuid/uuid.dart';
import './tote/day.dart';
import './tote/tote.dart';

const _uuid = Uuid();

class Trip {
  final String _id;
  String city;
  List<Day> days;
  Tote? tote;
  DateTime startDate;
  DateTime endDate;

  Trip({
    required this.city,
    required this.days,
    required this.startDate,
    required this.endDate,
    this.tote,
  }) : _id = _uuid.v4();
}

extension MutableTrip on Trip {
  List<Day> replaceDayByDayCode(int dayCode, Day newDay) {
    return days
        .map((Day day) => day.dayCode == dayCode ? newDay : day)
        .toList();
  }

  Trip replaceDayInTrip(int dayCode, Day newDay) {
    return Trip(
      city: city,
      days: replaceDayByDayCode(dayCode, newDay),
      startDate: startDate,
      endDate: endDate,
    );
  }

  Trip selectOutfitItem(
      int dayCode, int outfitOrdering, String itemType, bool newSelected) {
    final dayToUpdate = days.firstWhere((Day day) => day.dayCode == dayCode);
    return Trip(
      city: city,
      days: replaceDayByDayCode(
          dayCode,
          dayToUpdate.selectOutfitItem(
              outfitOrdering: outfitOrdering,
              itemType: itemType,
              newSelected: newSelected)),
      startDate: startDate,
      endDate: endDate,
    );
  }

  Trip changeOutfitType(dayCode, outfitOrdering, newType) {
    final dayToUpdate = days.firstWhere((Day day) => day.dayCode == dayCode);
    return Trip(
      city: city,
      days: replaceDayByDayCode(dayCode, dayToUpdate.changeOutfitType(outfitOrdering, newType)),
      startDate: startDate,
      endDate: endDate,
    );
  }

  Trip copyWith({
    String? city,
    List<Day>? days,
    Tote? tote,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Trip(city: city ?? this.city, days: days ?? this.days, tote: tote ?? this.tote, startDate: startDate ?? this.startDate, endDate: endDate ?? this.endDate);
  }
}

// class TripNotifier extends StateNotifier<Trip> {
//   TripNotifier(Trip newTrip)
//       : super(
//           Trip(
//               city: newTrip.city,
//               days: newTrip.days,
//               tote: newTrip.tote,
//               startDate: newTrip.startDate,
//               endDate: newTrip.endDate),
//         );

//   // **** UPDATE TRIP FUNCTIONS **** //

//   void loadTrip(Trip trip) {
//     state = trip;
//   }

//   void setStartDate(DateTime newDate) {
//     state = Trip(
//       startDate: newDate,
//       city: state.city,
//       days: state.days,
//       tote: state.tote,
//       endDate: state.endDate,
//     );
//   }

//   void setEndDate(DateTime newDate) {
//     state = Trip(
//       endDate: newDate,
//       city: state.city,
//       days: state.days,
//       tote: state.tote,
//       startDate: state.startDate,
//     );
//   }

//   void updateCity(String cityName) {
//     state = Trip(
//       city: cityName,
//       endDate: state.endDate,
//       days: state.days,
//       tote: state.tote,
//       startDate: state.startDate,
//     );
//   }

//   // **** UPDATE ITEM FUNCTIONS **** //

//   void selectItem(
//       int dayIndex, int outfitOrdering, OutfitItem item, bool value) {
//     state = state.selectOutfitItem(dayIndex, outfitOrdering, item.type, value);
//   }

//   void changeOutfitType(
//       int dayIndex, int outfitOrdering, OutfitTemplate newType) {
//     List<Day> newDays = [...state.days];
//     if (newDays[dayIndex].outfits != null) {
//       newDays[dayIndex].outfits![outfitOrdering] =
//           Outfit.fromTemplate(newType, outfitOrdering);
//     }

//     state = Trip(
//       city: state.city,
//       endDate: state.endDate,
//       tote: state.tote,
//       startDate: state.startDate,
//       days: newDays,
//     );
//   }

//   void addOutfitToDay(int dayIndex, OutfitTemplate outfitTemplate) {
//     List<Day> newDays = [...state.days];
//     if (newDays[dayIndex].outfits != null) {
//       newDays[dayIndex].addOutfit(Outfit.fromTemplate(
//           outfitTemplate, newDays[dayIndex].outfits!.length));
//     }
//     state = Trip(
//       city: state.city,
//       endDate: state.endDate,
//       tote: state.tote,
//       startDate: state.startDate,
//       days: newDays,
//     );
//   }

//   // void replaceOutfitItem(
//   //     int dayIndex, int outfitOrdering, OutfitItem newItem) {
//   //       final newDay = state.
//   //     }
// }

// final tripProvider = StateNotifierProvider<TripNotifier, Trip>((ref) {
//   // final days = ref.watch(dayListProvider);
//   return TripNotifier(Trip(
//     city: "",
//     days: [],
//     startDate: DateTime.now(),
//     endDate: DateTime.now(),
//   ));
// });
