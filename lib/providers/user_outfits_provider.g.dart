// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_outfits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserOutfits)
final userOutfitsProvider = UserOutfitsProvider._();

final class UserOutfitsProvider
    extends $AsyncNotifierProvider<UserOutfits, List<OutfitTemplate>> {
  UserOutfitsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userOutfitsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userOutfitsHash();

  @$internal
  @override
  UserOutfits create() => UserOutfits();
}

String _$userOutfitsHash() => r'e034c1d0061f6180c0100f2649f1990a04f83bdc';

abstract class _$UserOutfits extends $AsyncNotifier<List<OutfitTemplate>> {
  FutureOr<List<OutfitTemplate>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<OutfitTemplate>>, List<OutfitTemplate>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<OutfitTemplate>>, List<OutfitTemplate>>,
        AsyncValue<List<OutfitTemplate>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
