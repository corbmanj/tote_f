import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/wi.dart';

Widget getDayIcon(String iconString) {
  switch (iconString) {
    case 'partly-cloudy-day':
      return const Iconify(Wi.day_sunny_overcast);
    case 'cloudy':
      return const Iconify(Wi.cloudy);
    case 'rain':
      return const Iconify(Wi.rain);
    case 'clear-day':
      return const Iconify(Wi.day_sunny);
  }
  return const Iconify(Wi.day_sunny);
}
