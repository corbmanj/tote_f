import 'package:flutter/material.dart';

import '../models/tote/named.dart';
import '../models/tote/tote.dart';
import '../models/tote/unnamed.dart';
import '../models/trip.dart';

import '../models/tote/additional_item_section.dart';
import '../models/tote/additional_item.dart';
import '../models/tote/day.dart';
import '../models/tote/outfit.dart';
import '../models/user/outfit_template.dart';
import '../models/user/item_template.dart';

// Build Outfit Items
ItemTemplate runningShoes() {
  return ItemTemplate("Running Shoes", true, "shoes");
}

ItemTemplate runningSocks() {
  return ItemTemplate("Running Socks", false);
}

ItemTemplate runningBottoms() {
  return ItemTemplate("Running Bottoms", true, "bottoms");
}

ItemTemplate rundies() {
  return ItemTemplate("rundies", false);
}

ItemTemplate sportsBra() {
  return ItemTemplate("Sports Bra", true, "bras");
}

ItemTemplate workoutTop() {
  return ItemTemplate("Workout Top", true, "tops");
}

ItemTemplate runCoat() {
  return ItemTemplate("Running Coat", true, "coats");
}

ItemTemplate runHat() {
  return ItemTemplate("Running Hat", true, "hats");
}

ItemTemplate runGloves() {
  return ItemTemplate("Running Gloves", true, "gloves");
}

ItemTemplate workShoes() {
  return ItemTemplate("Work Shoes", true, "shoes");
}

ItemTemplate socks() {
  return ItemTemplate("Socks", false);
}

ItemTemplate workPants() {
  return ItemTemplate("Work Pants", true, "bottoms");
}

ItemTemplate undies() {
  return ItemTemplate("undies", false);
}

ItemTemplate bra() {
  return ItemTemplate("Bra", true, "bras");
}

ItemTemplate belt() {
  return ItemTemplate("Belt", true, "belts");
}

ItemTemplate workTop() {
  return ItemTemplate("Work Top", true, "tops");
}

ItemTemplate sweater() {
  return ItemTemplate("Sweater", true, "sweaters&sweatshirts");
}

ItemTemplate coat() {
  return ItemTemplate("Coat", true, "coats");
}

ItemTemplate hat() {
  return ItemTemplate("Hat", true, "hats");
}

ItemTemplate gloves() {
  return ItemTemplate("Gloves", true, "gloves");
}

ItemTemplate jewelry() {
  return ItemTemplate("Jewelry", true, "jewelry");
}

ItemTemplate scarf() {
  return ItemTemplate("Scarf", true, "scarves");
}

ItemTemplate shoes() {
  return ItemTemplate("Shoes", true, "shoes");
}

ItemTemplate casualPants() {
  return ItemTemplate("Casual Pants", true, "bottoms");
}

ItemTemplate top() {
  return ItemTemplate("Top", true, "tops");
}

ItemTemplate sleepSocks() {
  return ItemTemplate("Sleep Socks", true, "sleepSocks");
}

ItemTemplate sleepPants() {
  return ItemTemplate("Sleep Pants", true, "bottoms");
}

ItemTemplate sleepBra() {
  return ItemTemplate("Sleep Bra", true, "bras");
}

ItemTemplate sleepShirt() {
  return ItemTemplate("Sleep Top", true, "tops");
}

ItemTemplate sweatshirt() {
  return ItemTemplate("Work Top", true, "sweaters&sweatshirts");
}

ItemTemplate formalShoes() {
  return ItemTemplate("Formal Shoes", true, "shoes");
}

ItemTemplate formalPants() {
  return ItemTemplate("Formal Pants", true, "bottoms");
}

ItemTemplate formalTop() {
  return ItemTemplate("Formal Top", true, "tops");
}

ItemTemplate dress() {
  return ItemTemplate("Dress", true, "tops");
}

ItemTemplate otherShoes() {
  return ItemTemplate("Other Shoes", true, "shoes");
}

ItemTemplate otherPants() {
  return ItemTemplate("Other Pants", true, "bottoms");
}

ItemTemplate otherBelt() {
  return ItemTemplate("Other Belt", true, "belts");
}

ItemTemplate otherTop() {
  return ItemTemplate("Other Top", true, "tops");
}

ItemTemplate otherCoat() {
  return ItemTemplate("Other Coat", true, "coats");
}

// Build Outfit Types
OutfitTemplate workout = OutfitTemplate("Workout", [
  runningShoes(),
  runningSocks(),
  runningBottoms(),
  rundies(),
  sportsBra(),
  workoutTop(),
  runCoat(),
  runHat(),
  runGloves()
]);

OutfitTemplate workOutfit = OutfitTemplate("Work", [
  workShoes(),
  socks(),
  workPants(),
  undies(),
  belt(),
  bra(),
  workTop(),
  sweater(),
  coat(),
  hat(),
  gloves(),
  jewelry(),
  scarf(),
]);

OutfitTemplate casualOutfit = OutfitTemplate("Casual", [
  shoes(),
  socks(),
  casualPants(),
  undies(),
  belt(),
  bra(),
  top(),
  sweater(),
  coat(),
  hat(),
  gloves(),
  jewelry(),
  scarf(),
]);

OutfitTemplate sleepOutfit = OutfitTemplate("Sleep", [
  sleepSocks(),
  sleepPants(),
  rundies(),
  sleepBra(),
  sleepShirt(),
  sweatshirt(),
]);

OutfitTemplate formalOutfit = OutfitTemplate("Formal Outfit", [
  formalShoes(),
  socks(),
  formalPants(),
  undies(),
  belt(),
  bra(),
  formalTop(),
  sweater(),
  coat(),
  hat(),
  gloves(),
  jewelry(),
  scarf(),
  dress(),
]);

OutfitTemplate otherOutfit = OutfitTemplate("Other", [
  otherShoes(),
  socks(),
  otherPants(),
  undies(),
  otherBelt(),
  bra(),
  otherTop(),
  sweater(),
  otherCoat(),
  hat(),
  gloves(),
  jewelry(),
  scarf(),
]);

List<OutfitTemplate> outfitTypeList = [
  workout,
  workOutfit,
  casualOutfit,
  sleepOutfit,
  formalOutfit,
  otherOutfit,
];
// Build Additional Item Sections
AdditionalItem computer = AdditionalItem("computer");
AdditionalItem computerCharger = AdditionalItem("computer charger");
AdditionalItem phone = AdditionalItem("phone");
AdditionalItem phoneCharger = AdditionalItem("phone charger");
AdditionalItem gpsWatch = AdditionalItem("gps watch");
AdditionalItem watchCharger = AdditionalItem("watch charger");
AdditionalItem ipad = AdditionalItem("ipad");
AdditionalItem ipadCharger = AdditionalItem("ipad charger");
AdditionalItem headphones = AdditionalItem("headphones");
AdditionalItem headphoneSplitter = AdditionalItem("headphone splitter");
AdditionalItemSection electronics = AdditionalItemSection("electronics", [
  computer,
  computerCharger,
  phone,
  phoneCharger,
  gpsWatch,
  watchCharger,
  ipad,
  ipadCharger,
  headphones,
  headphoneSplitter
]);

AdditionalItem brownPurse = AdditionalItem("brown purse");
AdditionalItem blackTote = AdditionalItem("black tote");
AdditionalItem blueBackpack = AdditionalItem("blue travel backpack");
AdditionalItemSection bags =
    AdditionalItemSection("bags", [brownPurse, blackTote, blueBackpack]);

AdditionalItem toiletKit = AdditionalItem("toilet kit");
AdditionalItemSection toiletries =
    AdditionalItemSection("toiletries", [toiletKit]);

AdditionalItem waterBottle = AdditionalItem("water bottle");
AdditionalItemSection snacks = AdditionalItemSection("snacks", [waterBottle]);

AdditionalItem umbrella = AdditionalItem("umbrella");
AdditionalItemSection misc = AdditionalItemSection("misc", [umbrella]);

// Build Days
Outfit work0 = Outfit.fromTemplate(workOutfit, 0);
Outfit sleep0 = Outfit.fromTemplate(sleepOutfit, 1);
Day day0 = Day(
  84,
  DateTime(2022, 10, 18),
  36.37,
  61.04,
  "clear-day",
  0,
  1666052400,
  1666012500,
  "Clear throughout the day.",
  [work0, sleep0],
);

Outfit workout1 = Outfit.fromTemplate(workout, 0);

Outfit work1 = Outfit.fromTemplate(workOutfit, 1);

Day day1 = Day(85, DateTime(2022, 10, 19), 38.83, 64.83, "clear-day", 0, 1666138680, 1666098960,
    "Clear throughout the day.", [workout1, work1]);

Outfit workout2 = Outfit.fromTemplate(workout, 0);

Outfit work2 = Outfit.fromTemplate(workOutfit, 1);

Day day2 = Day(86, DateTime(2022, 10, 20), 45.05, 70.54, "clear-day", 0, 1666225020, 1666185420,
    "Clear throughout the day.", [workout2, work2]);

Outfit work3 = Outfit.fromTemplate(workOutfit, 0);

Day day3 = Day(
  87,
  DateTime(2022, 10, 21),
  44.13,
  76.05,
  "clear-day",
  0,
  1666311360,
  1666271880,
  "Clear throughout the day.",
  [work3],
);

// Build Tote

// unnamed items
Unnamed u1 = Unnamed("Socks", 4);
Unnamed u2 = Unnamed("Undies", 4);
Unnamed u3 = Unnamed("Rundies", 3);
Unnamed u4 = Unnamed("Running Socks", 2);

// named items
Named n1 = Named("Black Atreus", "shoes", 1);
Named n2 = Named("Black work pants", "bottoms", 2);
Named n3 = Named("Tan bra", "bras", 3);
Named n4 = Named("Work top 1", "tops", 4);
Named n5 = Named("Sweater 1", "sweaters&sweatshirts", 5);
Named n6 = Named("Black Patagonia coat", "coats", 6);
Named n7 = Named("Tan ear warmer", "hats", 7);
Named n8 = Named("Black gloves", "gloves", 8);
Named n9 = Named("Simple necklace & earrings", "jewelry", 9);
Named n10 = Named("Rainbow scarf", "scarves", 10);
Named n11 = Named("Sleep leggings", "bottoms", 11);
Named n12 = Named("Sleep bra", "bras", 12);
Named n13 = Named("Sleep shirt", "tops", 13);
Named n14 = Named("Black sweatshirt", "sweaters&sweatshirts", 14);
Named n15 = Named("Run shorts", "bottoms", 15);
Named n16 = Named("Sports bra 1", "bras", 16);
Named n17 = Named("Running tank", "tops", 17);
Named n18 = Named("LS run shirt", "coats", 18);
Named n19 = Named("Black ear warmer", "hts", 19);
Named n20 = Named("Run mittens", "gloves", 20);
Named n21 = Named("Jeans", "bottoms", 21);
Named n22 = Named("Black belt", "belts", 22);
Named n23 = Named("under-sweater tank", "tops", 23);
Named n24 = Named("Tan sweater", "sweaters&sweatshirts", 24);
Named n25 = Named("Run tights", "bottoms", 25);
Named n26 = Named("Sports bra 2", "bras", 26);
Named n27 = Named("SS run shirt", "tops", 27);
Named n28 = Named("Blue windbreaker", "coats", 28);
Named n29 = Named("Black work pants 2", "bottoms", 29);
Named n30 = Named("Work top 2", "tops", 30);
Named n31 = Named("Work top 3", "tops", 31);

List<Named> namedList = [
  n1,
  n2,
  n3,
  n4,
  n5,
  n6,
  n7,
  n8,
  n9,
  n10,
  n11,
  n12,
  n13,
  n14,
  n15,
  n16,
  n17,
  n18,
  n19,
  n20,
  n21,
  n22,
  n23,
  n24,
  n25,
  n26,
  n27,
  n28,
  n29,
  n30,
  n31
];

Tote tote = Tote(
    named: namedList,
    unnamed: [u1, u2, u3, u4],
    additionalItems: [electronics, bags, snacks, toiletries, misc]);

// Build Trip
Trip trip = Trip(
  city: "Boulder, CO",
  days: [day0, day1, day2],
  tote: tote,
  dateRange: DateTimeRange(
    start: DateTime(2022, 10, 18),
    end: DateTime(2022, 10, 20),
  ),
);

Trip trip2 = Trip(
  city: "Austin, TX",
  days: [day0, day1, day2, day3],
  tote: tote,
  dateRange: DateTimeRange(
    start: DateTime(2022, 10, 2),
    end: DateTime(2022, 11, 1),
  ),
);

List<Trip> trips = [trip, trip2];
