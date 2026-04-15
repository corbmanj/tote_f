// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_named.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateNamed)
final updateNamedProvider = UpdateNamedProvider._();

final class UpdateNamedProvider extends $NotifierProvider<UpdateNamed, void> {
  UpdateNamedProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'updateNamedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateNamedHash();

  @$internal
  @override
  UpdateNamed create() => UpdateNamed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$updateNamedHash() => r'c2a8273ecfd59cc04c25681a0afc6cb954b61e83';

abstract class _$UpdateNamed extends $Notifier<void> {
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
