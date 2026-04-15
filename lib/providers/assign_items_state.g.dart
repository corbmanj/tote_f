// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_items_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssignItemsState)
final assignItemsStateProvider = AssignItemsStateProvider._();

final class AssignItemsStateProvider
    extends $NotifierProvider<AssignItemsState, AssignStateType> {
  AssignItemsStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'assignItemsStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$assignItemsStateHash();

  @$internal
  @override
  AssignItemsState create() => AssignItemsState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssignStateType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssignStateType>(value),
    );
  }
}

String _$assignItemsStateHash() => r'd46f53221b1dd0f66adad506ec86bcdbede7d8a9';

abstract class _$AssignItemsState extends $Notifier<AssignStateType> {
  AssignStateType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AssignStateType, AssignStateType>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AssignStateType, AssignStateType>,
        AssignStateType,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
