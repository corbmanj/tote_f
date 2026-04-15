// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packing_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PackingListNotifier)
final packingListProvider = PackingListNotifierProvider._();

final class PackingListNotifierProvider
    extends $NotifierProvider<PackingListNotifier, PackingListType> {
  PackingListNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'packingListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$packingListNotifierHash();

  @$internal
  @override
  PackingListNotifier create() => PackingListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackingListType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackingListType>(value),
    );
  }
}

String _$packingListNotifierHash() =>
    r'4495c25be7e048d1df483f54b062027a8a3d9023';

abstract class _$PackingListNotifier extends $Notifier<PackingListType> {
  PackingListType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PackingListType, PackingListType>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PackingListType, PackingListType>,
        PackingListType,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
