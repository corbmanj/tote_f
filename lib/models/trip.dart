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
