// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TripList)
final tripListProvider = TripListProvider._();

final class TripListProvider
    extends $AsyncNotifierProvider<TripList, List<TripMeta>> {
  TripListProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tripListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tripListHash();

  @$internal
  @override
  TripList create() => TripList();
}

String _$tripListHash() => r'3232b8e89ec05977a52a2281af1e8a80a25d9ba5';

abstract class _$TripList extends $AsyncNotifier<List<TripMeta>> {
  FutureOr<List<TripMeta>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<TripMeta>>, List<TripMeta>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<TripMeta>>, List<TripMeta>>,
        AsyncValue<List<TripMeta>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
