// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_additional_items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserAdditionalItems)
final userAdditionalItemsProvider = UserAdditionalItemsProvider._();

final class UserAdditionalItemsProvider extends $AsyncNotifierProvider<
    UserAdditionalItems, UserAdditionalItemsAndSections> {
  UserAdditionalItemsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userAdditionalItemsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userAdditionalItemsHash();

  @$internal
  @override
  UserAdditionalItems create() => UserAdditionalItems();
}

String _$userAdditionalItemsHash() =>
    r'88d3e61defc682c6a0dd74e216e958d17086e73e';

abstract class _$UserAdditionalItems
    extends $AsyncNotifier<UserAdditionalItemsAndSections> {
  FutureOr<UserAdditionalItemsAndSections> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserAdditionalItemsAndSections>,
        UserAdditionalItemsAndSections>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<UserAdditionalItemsAndSections>,
            UserAdditionalItemsAndSections>,
        AsyncValue<UserAdditionalItemsAndSections>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
