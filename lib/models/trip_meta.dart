import 'package:flutter/material.dart';

class TripMeta {
  final int id;
  final String name;
  final String city;
  final DateTimeRange dateRange;
  TripMeta(this.id, this.name, this.city, this.dateRange);

  factory TripMeta.fromMap(Map<String, dynamic> map) {
    final dateTime = DateTimeRange(
      start: DateTime.fromMillisecondsSinceEpoch(map['startDate'].toInt()),
      end: DateTime.fromMillisecondsSinceEpoch(map['endDate'].toInt()),
    );
    return TripMeta(
      map['id']?.toInt() ?? 0,
      map['name'],
      map['city'] ?? '',
      dateTime,
    );
  }

  TripMeta copyWith({
    int? id,
    String? name,
    String? city,
    DateTimeRange? dateRange,
  }) {
    return TripMeta(
      id ?? this.id,
      name ?? this.name,
      city ?? this.city,
      dateRange ?? this.dateRange,
    );
  }
}

final TripMeta defaultTripMeta = TripMeta(
  -1,
  "",
  "",
  DateTimeRange(start: DateTime.now(), end: DateTime.now()),
);