// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdditionalItemsNotifier)
final additionalItemsProvider = AdditionalItemsNotifierProvider._();

final class AdditionalItemsNotifierProvider extends $NotifierProvider<
    AdditionalItemsNotifier, List<AdditionalItemSection>> {
  AdditionalItemsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'additionalItemsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$additionalItemsNotifierHash();

  @$internal
  @override
  AdditionalItemsNotifier create() => AdditionalItemsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AdditionalItemSection> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AdditionalItemSection>>(value),
    );
  }
}

String _$additionalItemsNotifierHash() =>
    r'94f1c5bed7ed36375c2ffbc2cfa0c03a6e509555';

abstract class _$AdditionalItemsNotifier
    extends $Notifier<List<AdditionalItemSection>> {
  List<AdditionalItemSection> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<List<AdditionalItemSection>, List<AdditionalItemSection>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<AdditionalItemSection>, List<AdditionalItemSection>>,
        List<AdditionalItemSection>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
