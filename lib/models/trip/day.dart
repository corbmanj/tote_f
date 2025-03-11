import 'dart:convert';
import 'package:collection/collection.dart';
import 'outfit.dart';

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

  Day({
    required this.dayCode,
    required this.day,
    required this.low,
    required this.high,
    required this.icon,
    required this.precip,
    required this.sunrise,
    required this.sunset,
    required this.summary,
    this.outfits = const [],
  });

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

  factory Day.defaultDay(DateTime day) {
    return Day(
      dayCode: day.millisecondsSinceEpoch,
      day: day,
      low: 0,
      high: 0,
      icon: "",
      precip: 0.0,
      sunset: 0,
      sunrise: 0,
      summary: "",
    );
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      dayCode: map['dayCode'] ?? 0,
      day: DateTime.fromMillisecondsSinceEpoch(map['day']),
      low: map['low'],
      high: map['high'],
      icon: map['icon'],
      precip: map['precip'],
      sunset: map['sunset'],
      sunrise: map['sunrise'],
      summary: map['summary'],
      outfits: jsonDecode(map['outfits'] ?? '[]')
          .map<Outfit>((outfit) => Outfit.fromMap(outfit))
          .toList(),
    );
  }

  int getNextOrdering() {
    return outfits?.length ?? 0;
  }

  void addOutfitCopy(Outfit outfit) {
    final newOrdering = getNextOrdering();
    final newOutfit = outfit.copyWith(ordering: newOrdering);
    if (outfits == null) {
      outfits = [newOutfit];
    } else {
      outfits = [...outfits!, newOutfit];
    }
  }

  void deleteOutfit(Outfit outfit) {
    if (outfits != null && outfits!.isNotEmpty) {
      outfits = outfits!
          .whereNot((Outfit oldOutfit) => oldOutfit.ordering == outfit.ordering)
          .toList();
    }
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
      dayCode: dayCode ?? this.dayCode,
      day: day ?? this.day,
      low: low ?? this.low,
      high: high ?? this.high,
      icon: icon ?? this.icon,
      precip: precip ?? this.precip,
      sunset: sunrise ?? this.sunrise,
      sunrise: sunset ?? this.sunset,
      summary: summary ?? this.summary,
      outfits: outfits ?? this.outfits,
    );
  }

  Day updateOutfitList({required List<Outfit> newOutfits}) {
    return Day(
      dayCode: dayCode,
      day: day,
      low: low,
      high: high,
      icon: icon,
      precip: precip,
      sunset: sunrise,
      sunrise: sunset,
      summary: summary,
      outfits: newOutfits,
    );
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

  Day addOutfit(Outfit outfit) {
    if (outfits == null) {
      return copyWith(outfits: [outfit]);
    }
    return copyWith(outfits: [...outfits!, outfit]);
  }

  Day changeOutfitType(int outfitOrdering, Outfit newOutfit) {
    if (outfits == null) {
      return this;
    }
    return copyWith(
        outfits: outfits!
            .map((Outfit outfit) =>
                outfit.ordering == outfitOrdering ? newOutfit : outfit)
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
