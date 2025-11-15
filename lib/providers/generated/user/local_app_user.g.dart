// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../user/local_app_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalUserProvider)
const localUserProvider = LocalUserProviderProvider._();

final class LocalUserProviderProvider
    extends $AsyncNotifierProvider<LocalUserProvider, AppUser> {
  const LocalUserProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localUserProviderHash();

  @$internal
  @override
  LocalUserProvider create() => LocalUserProvider();
}

String _$localUserProviderHash() => r'1deb42580d4c9af9256135a6b599f611b0a36256';

abstract class _$LocalUserProvider extends $AsyncNotifier<AppUser> {
  FutureOr<AppUser> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AppUser>, AppUser>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppUser>, AppUser>,
              AsyncValue<AppUser>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
