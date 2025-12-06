# Špacírtrasa

Mobilní aplikace pro zobrazení tras a zajímavostí okolo obce Ořechov u Brna.

---

### Spuštění:

Pro používání aplikace je potřeba aplikaci nainstalovat za pomocí souboru *Spacirtrasa.apk*

### Vlastní úprava projektu:

Pro vlastní úpravu a sestavení projektu je potřeba mít vývojové prostředí s Flutter SDK (
viz https://docs.flutter.dev/get-started/quick)

Dále je potřeba přidat službu Firebase s vlastním projektem (
viz https://firebase.google.com/docs/flutter/setup?platform=android) a s těmito pluginy:

- `cloud_firestore` (pro zálohování dat v cloudu)
- `firebase_auth` (pro autentizaci uživatelů)
- `firebase_app_check` (pro zabezpečení přístupu k Firebase službám jen z vaší aplikace)

Následně je potřeba získat API klíč (viz https://developer.mapy.com/rest-api-mapy-cz/api-key/) pro
mapové podklady od firmy Seznam.cz, a.s. a jejich služby Mapy.com, jejíž mapové podklady tato
aplikace používá. Tuto hodnotu je následně potřeba uložit ve formátu `MAP_API_KEY=XXXXXXXXXXXXXXXXX`
do vytvořeného souboru `.env` v kořenovém adresáři projektu.

Po sestavení, spuštění aplikace a přihlášení se pomocí Google účtu lze uživatele povýšit na
administrátor a to skrze Firebase Console, skrze níž se lze připojit do Firestore databáze.
Upravením parametru `is_admin` na `true`
v kolekci `users`, daného uživatele povýšime na administrátora. Administrátor, skrze stránku *Moje*,
následně může vytvářet a mazat zajímavosti a trasy (pár testovacích již připravených ve složce
*test_data*).

---

### Užitečné příkazy:

- `flutter pub get` - nainstaluje závislosti projektu
- `flutter run` - spustí aplikaci na připojeném zařízení nebo emulátoru
- `dart run build_runner watch -d` - sleduje změny ve třídách, pro které se dogenerovává kód a
  automaticky kód generuje
- `flutter build apk --release` - sestaví produkční APK soubor aplikace

---
---

# EN - Špacírtrasa:

Mobile application for displaying routes and points of interest around the village of Ořechov u
Brna.

---

### Launch:

To use the application, you need to install the application using the *Spacirtrasa.apk* file

### Custom project editing:

To customize and build the project, you need to have a development environment with the Flutter
SDK (
see https://docs.flutter.dev/get-started/quick)

Next, you need to add the Firebase service with your own project (
see https://firebase.google.com/docs/flutter/setup?platform=android) and these plugins:

- `cloud_firestore` (for backing up data in the cloud)
- `firebase_auth` (for user authentication)
- `firebase_app_check` (for securing access to Firebase services only from your application)

Then you need to obtain an API key (see https://developer.mapy.com/rest-api-mapy-cz/api-key/) for
map data from Seznam.cz, a.s. and their Mapy.com service, whose map data this
application uses. This value must then be saved in the format `MAP_API_KEY=XXXXXXXXXXXXXXX`
to the created `.env` file in the root directory of the project.

After building, running the application and logging in with a Google account, the user can be
promoted to
administrator via the Firebase Console, through which you can connect to the Firestore database.
By modifying the `is_admin` parameter to `true`
in the `users` collection, we will promote the given user to administrator. The administrator, via
the *My* page,
can then create and delete points of interest and routes (a few test ones already prepared in the
*test_data* folder).

---

### Useful commands:

- `flutter pub get` - installs project dependencies
- `flutter run` - runs the application on a connected device or emulator
- `dart run build_runner watch -d` - watches changes in classes for which code is generated and
  automatically generates code
- `flutter build apk --release` - builds the production APK file of the application