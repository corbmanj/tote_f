// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_day.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateDay)
final updateDayProvider = UpdateDayProvider._();

final class UpdateDayProvider extends $NotifierProvider<UpdateDay, void> {
  UpdateDayProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'updateDayProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateDayHash();

  @$internal
  @override
  UpdateDay create() => UpdateDay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$updateDayHash() => r'b1a092781ef05f4ba175158a6ff9495403c5e274';

abstract class _$UpdateDay extends $Notifier<void> {
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
