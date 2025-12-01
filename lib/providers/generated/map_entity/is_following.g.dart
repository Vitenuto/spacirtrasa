// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../map_entity/is_following.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsFollowingProvider)
const isFollowingProvider = IsFollowingProviderProvider._();

final class IsFollowingProviderProvider
    extends $NotifierProvider<IsFollowingProvider, AlignOnUpdate> {
  const IsFollowingProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isFollowingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isFollowingProviderHash();

  @$internal
  @override
  IsFollowingProvider create() => IsFollowingProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AlignOnUpdate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AlignOnUpdate>(value),
    );
  }
}

String _$isFollowingProviderHash() =>
    r'9dd5024e675e12cdf0e30a6b0711f78d993f6493';

abstract class _$IsFollowingProvider extends $Notifier<AlignOnUpdate> {
  AlignOnUpdate build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AlignOnUpdate, AlignOnUpdate>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AlignOnUpdate, AlignOnUpdate>,
              AlignOnUpdate,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
