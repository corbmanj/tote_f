// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_trip_consumer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateTripConsumer)
final createTripConsumerProvider = CreateTripConsumerProvider._();

final class CreateTripConsumerProvider
    extends $NotifierProvider<CreateTripConsumer, void> {
  CreateTripConsumerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'createTripConsumerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$createTripConsumerHash();

  @$internal
  @override
  CreateTripConsumer create() => CreateTripConsumer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$createTripConsumerHash() =>
    r'937d1515f28bb050d05303772a4138ce036c6d8c';

abstract class _$CreateTripConsumer extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
