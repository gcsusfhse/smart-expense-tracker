# Android Platform Folder

This folder would normally contain the auto-generated Flutter Android embedding (Gradle files, `AndroidManifest.xml`, `MainActivity.kt`, etc.) created by running:

```bash
flutter create .
```

from the project root. These files are intentionally not duplicated in full here to keep the repository focused on the Dart/Flutter application source code, since they are regenerated automatically by the Flutter CLI for every fresh checkout.

## Key configuration applied in this project

When you run `flutter create .`, make sure the following are set in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

This permission is required for the **Budget Limit Notification** feature (see `lib/services/notification_service.dart`).

Also set the app label and icon:

```xml
<application
    android:label="Smart Expense Tracker"
    android:icon="@mipmap/ic_launcher">
```

Replace the default `ic_launcher` mipmap images with the icon at `assets/icons/app_icon.png` (resized appropriately for each density bucket), or generate them automatically using the `flutter_launcher_icons` package.
