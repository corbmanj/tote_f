// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserItems)
final userItemsProvider = UserItemsProvider._();

final class UserItemsProvider
    extends $AsyncNotifierProvider<UserItems, UserItemsAndGroups> {
  UserItemsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userItemsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userItemsHash();

  @$internal
  @override
  UserItems create() => UserItems();
}

String _$userItemsHash() => r'292162dd8e9aeb5d3174c5fc0146272e0abee135';

abstract class _$UserItems extends $AsyncNotifier<UserItemsAndGroups> {
  FutureOr<UserItemsAndGroups> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<UserItemsAndGroups>, UserItemsAndGroups>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<UserItemsAndGroups>, UserItemsAndGroups>,
        AsyncValue<UserItemsAndGroups>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
