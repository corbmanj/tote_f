import 'dart:convert';
import 'package:tote_f/models/user/outfit_template.dart';

import './outfit.dart';

class Day {
  int dayCode;
  DateTime day;
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
    this.day,
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

  Map toJson() => {
    'dayCode': dayCode,
    'day': day.millisecondsSinceEpoch,
    'low': low,
    'high': high,
    'icon': icon,
    'precip': precip,
    'sunset': sunset,
    'sunrise': sunrise,
    'summary': summary,
    'outfits': jsonEncode(outfits)
  };

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      map['dayCode'] ?? 0,
      DateTime.fromMillisecondsSinceEpoch(map['day']),
      map['low'],
      map['high'],
      map['icon'],
      map['precip'],
      map['sunset'],
      map['sunrise'],
      map['summary'],
      jsonDecode(map['outfits'] ?? '[]').map<Outfit>((outfit) => Outfit.fromMap(outfit)).toList(),
    );
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

  List<Outfit> nameOutfitItemByOrdering(
      {required int ordering,
      required String itemType,
      required int newNamedId}) {
    if (outfits == null) {
      return [];
    }
    return outfits!
        .map((Outfit outfit) => outfit.ordering == ordering
            ? outfit.nameItemForOutfit(itemType, newNamedId)
            : outfit)
        .toList();
  }

  Day copyWith({
    int? dayCode,
    DateTime? day,
    double? low,
    double? high,
    String? icon,
    double? precip,
    int? sunrise,
    int? sunset,
    String? summary,
    List<Outfit>? outfits,
  }) {
    return Day(
      dayCode ?? this.dayCode,
      day ?? this.day,
      low ?? this.low,
      high ?? this.high,
      icon ?? this.icon,
      precip ?? this.precip,
      sunrise ?? this.sunrise,
      sunset ?? this.sunset,
      summary ?? this.summary,
      outfits ?? this.outfits,
    );
  }

  Day updateOutfitList({required List<Outfit> newOutfits}) {
    return Day(
        dayCode, day, low, high, icon, precip, sunrise, sunset, summary, newOutfits);
  }

  Day nameOutfitItem(
      {required int outfitOrdering,
      required String itemType,
      required int newNamedId}) {
    return updateOutfitList(
        newOutfits: nameOutfitItemByOrdering(
            ordering: outfitOrdering,
            itemType: itemType,
            newNamedId: newNamedId));
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

  Day addOutfit(OutfitTemplate newType) {
    if (outfits == null) {
      return copyWith(outfits: [Outfit.fromTemplate(newType, 0)]);
    }
    return copyWith(
        outfits: [...outfits!, Outfit.fromTemplate(newType, outfits!.length)]);
  }

  Day changeOutfitType(int outfitOrdering, OutfitTemplate newType) {
    if (outfits == null) {
      return this;
    }
    return copyWith(
        outfits: outfits!
            .map((Outfit outfit) => outfit.ordering == outfitOrdering
                ? outfit.changeType(newType, outfit.name)
                : outfit)
            .toList());
  }

  Day changeOutfitName(int outfitOrdering, String newName) {
    if (outfits == null) {
      return this;
    }
    return copyWith(
        outfits: outfits!
            .map((Outfit outfit) => outfit.ordering == outfitOrdering
                ? outfit.copyWith(name: newName)
                : outfit)
            .toList());
  }
}
