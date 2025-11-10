// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../note.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NoteProvider)
const noteProvider = NoteProviderProvider._();

final class NoteProviderProvider
    extends $NotifierProvider<NoteProvider, List<Note>> {
  const NoteProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noteProviderHash();

  @$internal
  @override
  NoteProvider create() => NoteProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Note> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Note>>(value),
    );
  }
}

String _$noteProviderHash() => r'6edcad0e4c30c872824e17e699bb3990bc9ec711';

abstract class _$NoteProvider extends $Notifier<List<Note>> {
  List<Note> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Note>, List<Note>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Note>, List<Note>>,
              List<Note>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
