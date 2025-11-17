import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast_io.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/services/user/app_user_service.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../generated/user/local_app_user.g.dart';

@Riverpod(keepAlive: true)
class LocalUserProvider extends _$LocalUserProvider {
  static final String localDbName = 'local_app_user.db';
  Database? _localDb;

  final _localUserStore = StoreRef<String, Map<String, dynamic>>.main();

  @override
  Future<AppUser> build() async {
    final appUser = await _getLocalAppUser();
    if (appUser == null) {
      return getEmptyAppUser();
    }
    return appUser;
  }

  Future<AppUser?> _getLocalAppUser() async {
    await _initDb();
    final record = await _localUserStore.record(localUserId).get(_localDb!);
    late final AppUser localUser;
    if (record != null) {
      localUser = AppUser.fromJson(record);
      logger.t("Local user record found: $localUser");
      return localUser;
    }
    logger.t("No local user record found");
    return null;
  }

  Future<void> _initDb() async {
    if (_localDb != null) return;

    final appPath = await getApplicationDocumentsDirectory();
    appPath.createSync(recursive: true);
    final dbPath = join(appPath.path, localDbName);
    logger.t("Opening database on path: $dbPath");
    _localDb = await databaseFactoryIo.openDatabase(dbPath);
    ref.onDispose(() {
      _localDb?.close();
    });
  }

  Future<void> setUser(AppUser appUser) async {
    logger.t("Updating local user: $appUser");
    await _initDb();
    await _localUserStore.record(appUser.id).put(_localDb!, appUser.toJson());
    state = AsyncData(appUser);
  }
}
