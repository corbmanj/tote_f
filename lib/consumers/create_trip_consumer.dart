import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/apis/fetch_weather.dart';
import 'package:tote_f/models/trip/day.dart';
import 'package:tote_f/models/tote/tote.dart';
import 'package:tote_f/models/trip/weather.dart';
import 'package:tote_f/models/trip/trip.dart';
import 'package:tote_f/models/trip_meta.dart';
import 'package:tote_f/providers/additional_items_provider.dart';
import 'package:tote_f/providers/named_items_provider.dart';
import 'package:tote_f/providers/trip_provider.dart';
import 'package:tote_f/providers/unnamed_items_provider.dart';
import 'package:tote_f/providers/user_additional_items_provider.dart';
import 'package:tote_f/services/db_service.dart';

part 'create_trip_consumer.g.dart';

@riverpod
class CreateTripConsumer extends _$CreateTripConsumer {
  @override
  void build() {}

  void loadTrip(Trip trip) {
    ref.read(tripNotifierProvider.notifier).loadTrip(trip);
  }

  void updateDates(DateTimeRange newDates) {
    final currentTrip = ref.watch(tripNotifierProvider);
    final newTrip = currentTrip.copyWith(
        dateRange: DateTimeRange(start: newDates.start, end: newDates.end));
    loadTrip(newTrip);
  }

  void updateCity(String city) {
    final currentTrip = ref.watch(tripNotifierProvider);
    final newTrip = currentTrip.copyWith(city: city);
    loadTrip(newTrip);
  }

  List<Day> createDayListFromWeather(
      WeatherResponse weather, DateTimeRange dateRange) {
    if (weather.success == true &&
        weather.days != null &&
        weather.days!.isNotEmpty) {
      return weather.days!
          .map((Weather day) => Day(
                dayCode: day.dateTime.millisecondsSinceEpoch,
                day: day.dateTime,
                low: day.low,
                high: day.high,
                icon: day.icon,
                precip: day.precip,
                sunset: day.sunset,
                sunrise: day.sunrise,
                summary: day.summary,
              ))
          .toList();
    }
    List<Day> dayList = [];
    for (var day = dateRange.start;
        day.compareTo(dateRange.end) <= 0;
        day = day.add(const Duration(days: 1))) {
      dayList.add(Day.defaultDay(day));
    }
    return dayList;
  }

  Future<Trip?> createTripFromSchedule(TripMeta tripMeta, {bool? reset = false}) async {
    print('Creating trip from schedule with TripMeta: ${tripMeta.name}, ${tripMeta.city}');
    final DatabaseService dbService = DatabaseService();
    final weatherResponse =
        await fetchWeather(tripMeta.city, tripMeta.dateRange);
    final List<Day> dayList = createDayListFromWeather(weatherResponse, tripMeta.dateRange);
    print('Created ${dayList.length} days for trip');
    final userAdditionalItemsAsync = await ref.watch(userAdditionalItemsProvider.future);
    final userData = userAdditionalItemsAsync;
    
    // Create a Trip from TripMeta
    final newTrip = Trip(
        id: tripMeta.id == -1 ? null : tripMeta.id,
        city: tripMeta.city,
        days: dayList,
        dateRange: tripMeta.dateRange,
        tote: Tote.fromUserAdditionalItemsAndSections(
          named: [],
          unnamed: [],
          userData: userData,
        ));
        
    int? newId = newTrip.id;
    if (reset == true && newTrip.id != null) {
      await dbService.saveTripById(newTrip, newTrip.id!);
      // Load the updated trip directly
      ref.read(tripNotifierProvider.notifier).loadTrip(newTrip);
      return newTrip;
    } else {
      newId = await dbService.createTrip(newTrip, name: tripMeta.name);
      print('Created trip in database with ID: $newId');
      // Create a new trip with the assigned ID and load it directly
      final tripWithId = Trip(
        id: newId,
        city: newTrip.city,
        days: newTrip.days,
        dateRange: newTrip.dateRange,
        tote: newTrip.tote,
      );
      ref.read(tripNotifierProvider.notifier).loadTrip(tripWithId);
      print('Loaded trip into provider with ${tripWithId.days.length} days');
      
      // Also load the related providers
      ref.read(namedItemsNotifierProvider.notifier).loadList(tripWithId.tote != null ? tripWithId.tote!.named : []);
      ref.read(additionalItemsNotifierProvider.notifier).loadList(tripWithId.tote != null ? tripWithId.tote!.additionalItems : []);
      ref.read(unnamedItemsNotifierProvider.notifier).initializeFromTote(tripWithId.tote != null ? tripWithId.tote!.unnamed : []);
      return tripWithId;
    }
  }
}
