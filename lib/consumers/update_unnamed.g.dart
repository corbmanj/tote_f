// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_unnamed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateUnnamed)
final updateUnnamedProvider = UpdateUnnamedProvider._();

final class UpdateUnnamedProvider
    extends $NotifierProvider<UpdateUnnamed, void> {
  UpdateUnnamedProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'updateUnnamedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateUnnamedHash();

  @$internal
  @override
  UpdateUnnamed create() => UpdateUnnamed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$updateUnnamedHash() => r'ce3e4af31c5c2a8695cac01c86b5197950684e70';

abstract class _$UpdateUnnamed extends $Notifier<void> {
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
