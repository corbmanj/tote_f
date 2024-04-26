import 'package:tote_f/models/tote/named.dart';
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
      required Named newNamed}) {
    if (outfits == null) {
      return [];
    }
    return outfits!
        .map((Outfit outfit) => outfit.ordering == ordering
            ? outfit.nameItemForOutfit(itemType, newNamed)
            : outfit)
        .toList();
  }

  Day copyWith({
    int? dayCode,
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
        dayCode, low, high, icon, precip, sunrise, sunset, summary, newOutfits);
  }

  Day nameOutfitItem(
      {required int outfitOrdering,
      required String itemType,
      required Named newNamed}) {
    return updateOutfitList(
        newOutfits: nameOutfitItemByOrdering(
            ordering: outfitOrdering,
            itemType: itemType,
            newNamed: newNamed));
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
                ? outfit.changeType(newType)
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
