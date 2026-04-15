// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outfit_list_expanded.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OutfitListExpanded)
final outfitListExpandedProvider = OutfitListExpandedProvider._();

final class OutfitListExpandedProvider
    extends $NotifierProvider<OutfitListExpanded, OutfitExpandedType> {
  OutfitListExpandedProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'outfitListExpandedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$outfitListExpandedHash();

  @$internal
  @override
  OutfitListExpanded create() => OutfitListExpanded();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OutfitExpandedType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OutfitExpandedType>(value),
    );
  }
}

String _$outfitListExpandedHash() =>
    r'7ea9cdf4f3bd0041f555987abbd13459da90c6fa';

abstract class _$OutfitListExpanded extends $Notifier<OutfitExpandedType> {
  OutfitExpandedType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<OutfitExpandedType, OutfitExpandedType>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<OutfitExpandedType, OutfitExpandedType>,
        OutfitExpandedType,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
