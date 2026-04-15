// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_outfit.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateOutfit)
final updateOutfitProvider = UpdateOutfitProvider._();

final class UpdateOutfitProvider extends $NotifierProvider<UpdateOutfit, void> {
  UpdateOutfitProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'updateOutfitProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateOutfitHash();

  @$internal
  @override
  UpdateOutfit create() => UpdateOutfit();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$updateOutfitHash() => r'4821562e84a60ca0d9162b040f24eccd4faa65b0';

abstract class _$UpdateOutfit extends $Notifier<void> {
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
