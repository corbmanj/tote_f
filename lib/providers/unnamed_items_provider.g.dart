// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unnamed_items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UnnamedItemsNotifier)
final unnamedItemsProvider = UnnamedItemsNotifierProvider._();

final class UnnamedItemsNotifierProvider
    extends $NotifierProvider<UnnamedItemsNotifier, List<Unnamed>> {
  UnnamedItemsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'unnamedItemsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$unnamedItemsNotifierHash();

  @$internal
  @override
  UnnamedItemsNotifier create() => UnnamedItemsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Unnamed> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Unnamed>>(value),
    );
  }
}

String _$unnamedItemsNotifierHash() =>
    r'66b545752a42f5b1a4fc3c9b53589aa3948465ad';

abstract class _$UnnamedItemsNotifier extends $Notifier<List<Unnamed>> {
  List<Unnamed> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Unnamed>, List<Unnamed>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<Unnamed>, List<Unnamed>>,
        List<Unnamed>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
