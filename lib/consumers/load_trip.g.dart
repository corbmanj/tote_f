// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_trip.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoadTrip)
final loadTripProvider = LoadTripProvider._();

final class LoadTripProvider extends $NotifierProvider<LoadTrip, void> {
  LoadTripProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'loadTripProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$loadTripHash();

  @$internal
  @override
  LoadTrip create() => LoadTrip();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$loadTripHash() => r'3d61bb38da18266af8ea0fb9691ca96ef9de0621';

abstract class _$LoadTrip extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
