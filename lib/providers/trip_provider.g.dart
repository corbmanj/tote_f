// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TripNotifier)
final tripProvider = TripNotifierProvider._();

final class TripNotifierProvider extends $NotifierProvider<TripNotifier, Trip> {
  TripNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tripProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tripNotifierHash();

  @$internal
  @override
  TripNotifier create() => TripNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Trip value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Trip>(value),
    );
  }
}

String _$tripNotifierHash() => r'c1b76049d64d3c954c8a611263603f926ea30849';

abstract class _$TripNotifier extends $Notifier<Trip> {
  Trip build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Trip, Trip>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Trip, Trip>, Trip, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
