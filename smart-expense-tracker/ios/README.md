# iOS Platform Folder

This folder would normally contain the auto-generated Flutter iOS embedding (Xcode project, `Info.plist`, `Runner.xcworkspace`, etc.) created by running:

```bash
flutter create .
```

from the project root. These files are intentionally not duplicated in full here to keep the repository focused on the Dart/Flutter application source code, since they are regenerated automatically by the Flutter CLI for every fresh checkout.

## Key configuration applied in this project

When you run `flutter create .`, ensure the following in `ios/Runner/Info.plist`:

```xml
<key>CFBundleDisplayName</key>
<string>Smart Expense Tracker</string>

<key>NSUserNotificationsUsageDescription</key>
<string>This app sends local notifications when you approach or exceed your monthly budget limit.</string>
```

This is required for the **Budget Limit Notification** feature to request permission correctly on iOS.
