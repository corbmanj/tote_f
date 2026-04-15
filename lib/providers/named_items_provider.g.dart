// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'named_items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NamedItemsNotifier)
final namedItemsProvider = NamedItemsNotifierProvider._();

final class NamedItemsNotifierProvider
    extends $NotifierProvider<NamedItemsNotifier, List<Named>> {
  NamedItemsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'namedItemsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$namedItemsNotifierHash();

  @$internal
  @override
  NamedItemsNotifier create() => NamedItemsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Named> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Named>>(value),
    );
  }
}

String _$namedItemsNotifierHash() =>
    r'a343734dde8014ad2f913c0f9dac7b839150d396';

abstract class _$NamedItemsNotifier extends $Notifier<List<Named>> {
  List<Named> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Named>, List<Named>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<Named>, List<Named>>, List<Named>, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
