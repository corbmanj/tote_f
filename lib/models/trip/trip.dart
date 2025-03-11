import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tote_f/models/tote/additional_item_section.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/models/trip/outfit.dart';
import 'package:tote_f/models/tote/unnamed.dart';
import 'day.dart';
import '../tote/tote.dart';

class Trip {
  int? id;
  String city;
  List<Day> days;
  Tote? tote;
  DateTimeRange dateRange;

  Trip({
    required this.city,
    required this.days,
    required this.dateRange,
    this.tote,
    this.id,
  });

  Map toJson() => {
        'id': id,
        'city': city,
        'days': jsonEncode(days),
        'tote': jsonEncode(tote),
        'startDate': dateRange.start.millisecondsSinceEpoch,
        'endDate': dateRange.end.millisecondsSinceEpoch,
      };

  factory Trip.fromMap(Map<String, dynamic> map, int tripId) {
    return Trip(
        id: tripId,
        city: map['city'],
        days: jsonDecode(map['days'])
            .map<Day>((day) => Day.fromMap(day))
            .toList(),
        dateRange: DateTimeRange(
            start: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
            end: DateTime.fromMillisecondsSinceEpoch(map['endDate'])),
        tote: map['tote'] == 'null'
            ? Tote(named: [], unnamed: [], additionalItems: [])
            : Tote.fromMap(jsonDecode(map['tote'])));
  }
}

extension MutableTrip on Trip {
  List<Day> replaceDayByDayCode(int dayCode, Day newDay) {
    return days
        .map((Day day) => day.dayCode == dayCode ? newDay : day)
        .toList();
  }
  
  Trip replaceDayInTrip(int dayCode, Day newDay) {
    return copyWith(
      city: city,
      days: replaceDayByDayCode(dayCode, newDay),
      dateRange: dateRange,
    );
  }

  Trip selectOutfitItem(
      int dayCode, int outfitOrdering, String itemType, bool newSelected) {
    final dayToUpdate = days.firstWhere((Day day) => day.dayCode == dayCode);
    return copyWith(
        city: city,
        days: replaceDayByDayCode(
            dayCode,
            dayToUpdate.selectOutfitItem(
                outfitOrdering: outfitOrdering,
                itemType: itemType,
                newSelected: newSelected)),
        dateRange: dateRange);
  }

  Trip changeOutfitType(dayCode, outfitOrdering, newType) {
    final dayToUpdate = days.firstWhere((Day day) => day.dayCode == dayCode);
    return copyWith(
        city: city,
        days: replaceDayByDayCode(
            dayCode, dayToUpdate.changeOutfitType(outfitOrdering, newType)),
        dateRange: dateRange);
  }

  Trip updateNamedList(List<Named> newNamed) {
    if (tote != null) {
      final Tote newTote = tote!.copyWith(named: newNamed);
      return copyWith(tote: newTote);
    }
    return this;
  }

  Trip updateUnnamedList(List<Unnamed> newList) {
    if (tote != null) {
      final Tote newTote = tote!.copyWith(unnamed: newList);
      return copyWith(tote: newTote);
    }
    return this;
  }

  Trip updateAdditionalItems(List<AdditionalItemSection> newAdditionalItems) {
    if (tote != null) {
      final Tote newTote = tote!.copyWith(additionalItems: newAdditionalItems);
      return copyWith(tote: newTote);
    }
    return this;
  }

  Trip copyOutfitToDays(List<int> daysToCopyTo, Outfit outfit) {
    for (final day in days) {
      if (daysToCopyTo.contains(day.dayCode)) {
        day.addOutfitCopy(outfit);
      }
    }
    return copyWith(days: days);
  }

  Trip copyWith({
    int? id,
    String? city,
    List<Day>? days,
    Tote? tote,
    DateTimeRange? dateRange,
  }) {
    return Trip(
        id: id ?? this.id,
        city: city ?? this.city,
        days: days ?? this.days,
        tote: tote ?? this.tote,
        dateRange: dateRange ?? this.dateRange);
  }
}
