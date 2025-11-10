// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../user/app_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppUserProvider)
const appUserProvider = AppUserProviderProvider._();

final class AppUserProviderProvider
    extends $NotifierProvider<AppUserProvider, AppUser> {
  const AppUserProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appUserProviderHash();

  @$internal
  @override
  AppUserProvider create() => AppUserProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppUser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppUser>(value),
    );
  }
}

String _$appUserProviderHash() => r'413f798b1ce95aff3cf25eae4597a13e10fdd08e';

abstract class _$AppUserProvider extends $Notifier<AppUser> {
  AppUser build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppUser, AppUser>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppUser, AppUser>,
              AppUser,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
