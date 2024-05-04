import 'package:flutter/material.dart';

class TripMeta {
  final int id;
  final String city;
  final DateTimeRange dateRange;
  TripMeta(this.id, this.city, this.dateRange);

  factory TripMeta.fromMap(Map<String, dynamic> map) {
    final dateTime = DateTimeRange(
      start: DateTime.fromMillisecondsSinceEpoch(map['startDate'].toInt()),
      end: DateTime.fromMillisecondsSinceEpoch(map['endDate'].toInt()),
    );
    return TripMeta(
      map['id']?.toInt() ?? 0,
      map['city'] ?? '',
      dateTime,
    );
  }
}