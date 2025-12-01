// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../expanded.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExpandedProvider)
const expandedProvider = ExpandedProviderProvider._();

final class ExpandedProviderProvider
    extends $NotifierProvider<ExpandedProvider, bool> {
  const ExpandedProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expandedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expandedProviderHash();

  @$internal
  @override
  ExpandedProvider create() => ExpandedProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$expandedProviderHash() => r'dd4a812bdccc23aab7681bb18d7b908aa0a957b2';

abstract class _$ExpandedProvider extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
