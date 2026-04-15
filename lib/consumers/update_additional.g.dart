// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_additional.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateAdditional)
final updateAdditionalProvider = UpdateAdditionalProvider._();

final class UpdateAdditionalProvider
    extends $NotifierProvider<UpdateAdditional, void> {
  UpdateAdditionalProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'updateAdditionalProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateAdditionalHash();

  @$internal
  @override
  UpdateAdditional create() => UpdateAdditional();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$updateAdditionalHash() => r'cd7e7c0b03fa0ae8f9decc8b1479de83c7aab91b';

abstract class _$UpdateAdditional extends $Notifier<void> {
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
