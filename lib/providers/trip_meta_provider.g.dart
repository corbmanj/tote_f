// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_meta_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TripMetaNotifier)
final tripMetaProvider = TripMetaNotifierProvider._();

final class TripMetaNotifierProvider
    extends $NotifierProvider<TripMetaNotifier, TripMeta> {
  TripMetaNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tripMetaProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tripMetaNotifierHash();

  @$internal
  @override
  TripMetaNotifier create() => TripMetaNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TripMeta value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TripMeta>(value),
    );
  }
}

String _$tripMetaNotifierHash() => r'8619f1b863c355b2e58f01e9c2c5295e77e33769';

abstract class _$TripMetaNotifier extends $Notifier<TripMeta> {
  TripMeta build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TripMeta, TripMeta>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<TripMeta, TripMeta>, TripMeta, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
