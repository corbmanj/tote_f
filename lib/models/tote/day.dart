import 'package:tote_f/models/user/outfit_template.dart';

import './outfit.dart';

class Day {
  int dayCode;
  double low;
  double high;
  String icon;
  double precip;
  int sunset;
  int sunrise;
  String summary;
  List<Outfit>? outfits;

  Day(
    this.dayCode,
    this.low,
    this.high,
    this.icon,
    this.precip,
    this.sunrise,
    this.sunset,
    this.summary, [
    this.outfits,
  ]) {
    outfits = outfits ?? [];
  }

  void addOutfit(Outfit outfit) {
    outfits?.add(outfit);
  }
}

extension MutableDay on Day {
  List<Outfit> replaceOutfitByOrdering(
      {required int ordering, required Outfit newOutfit}) {
    if (outfits == null) {
      return [];
    }
    return outfits!
        .map(
            (Outfit outfit) => outfit.ordering == ordering ? newOutfit : outfit)
        .toList();
  }

  List<Outfit> selectOutfitItemByOrdering(
      {required int ordering,
      required String itemType,
      required bool newSelected}) {
    if (outfits == null) {
      return [];
    }
    return outfits!
        .map((Outfit outfit) => outfit.ordering == ordering
            ? outfit.selectItemForOutfit(itemType, newSelected)
            : outfit)
        .toList();
  }

  Day updateOutfitList({required List<Outfit> newOutfits}) {
    return Day(
        dayCode, low, high, icon, precip, sunrise, sunset, summary, newOutfits);
  }

  Day selectOutfitItem(
      {required int outfitOrdering,
      required String itemType,
      required bool newSelected}) {
    return updateOutfitList(
        newOutfits: selectOutfitItemByOrdering(
            ordering: outfitOrdering,
            itemType: itemType,
            newSelected: newSelected));
  }

  Day changeOutfitType(int outfitOrdering, OutfitTemplate newType) {
    if (outfits != null) {
      return Day(dayCode, low, high, icon, precip, sunrise, sunset, summary);
    }
    return Day(
      dayCode,
      low,
      high,
      icon,
      precip,
      sunrise,
      sunset,
      summary,
      outfits!.map((Outfit outfit) => outfit.ordering == outfitOrdering ? outfit.changeType(newType) : outfit).toList()
    );
  }
}

// class DayNotifier extends StateNotifier<Day> {
//   DayNotifier(Day day)
//       : super(Day(
//           day.dayCode,
//           day.low,
//           day.high,
//           day.icon,
//           day.precip,
//           day.sunrise,
//           day.sunset,
//           day.summary,
//           day.outfits,
//         ));
// }

// final dayProvider = StateNotifierProvider<DayNotifier, Day>((ref) {
//   final outfits = ref.watch(outfitListProvider);
//   return DayNotifier(Day(0, 0, 0, "", 0, 0, 0, "", outfits));
// });

// class DayListNotifier extends StateNotifier<List<Day>> {
//   DayListNotifier(List<Day> dayList)
//       : super(dayList
//             .map((Day day) => Day(day.dayCode, day.low, day.high, day.icon,
//                 day.precip, day.sunrise, day.sunset, day.summary, day.outfits))
//             .toList());

//   void updateOutfits(int dayCode, List<Outfit> newOutfits) {
//     final List<Day> newDays = state;
//     state = newDays
//         .map((Day day) => day.dayCode == dayCode
//             ? day.updateOutfitList(newOutfits: newOutfits)
//             : day)
//         .toList();
//   }

//   void addDay(Day newDay) {
//     final List<Day> newDays = state;
//     newDays.add(newDay);
//     state = newDays;
//   }
// }

// final dayListProvider =
//     StateNotifierProvider<DayListNotifier, List<Day>>((ref) {
//   return DayListNotifier([]);
// });
