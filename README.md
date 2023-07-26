# FLUTTER APP TEMPLATE

This template works like an template app that you can just add stuff and still works. Its connected to a [Node TypeScript server](https://github.com/doggbmx/server-template) that holds the user database and anything related to the business model.

### List of techs used:

- Firebase Auth

#### Server

- Node
- TypeScript
- PostgreSQL

## How to make it run

#### **Setup Firebase**

1. Create your own project on the [Firebase Console](https://console.firebase.google.com/) or select an existing one.
2. Follow the instructions to add a new mobile app to your Firebase project. Make sure to select Flutter as the platform.
3. Download the configuration file `google-services.json` for Android or `GoogleService-Info.plist` for iOS and place it in the respective folders within your Flutter project (`android/app` for Android; `ios/Runner` for iOS).

#### **Add Firebase dependencies in the `pubspec.yaml`**

Make sure you have the following dependencies in your `pubspec.yaml` file. Ensure that the versions are appropriate, and it is recommended to check for the latest version on the [official Firebase for Flutter website](https://firebase.flutter.dev/).

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.0.0 # Add the Firebase Core package
  firebase_auth: ^3.0.0 # If you need Firebase Auth for authentication
  cloud_firestore: ^2.0.0 # If you need Firestore database
  # Other Firebase dependencies you may need
```

#### **Initialize Firebase in your application code:**

In the `main.dart` file or any other relevant location in your application, initialize Firebase. To do this, import the necessary packages and call the `Firebase.initializeApp()` method.

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}
```

#### **Create the `firebase_options.dart` file:**

In this file, you need to define the configuration options for Firebase. Use the information found in the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) file you downloaded in step 1. The content may vary depending on the Firebase SDK you are using, but here's a basic example:

```dart
import 'package:firebase_core/firebase_core.dart';

class FirebaseOptionsProvider {
  static FirebaseOptions getOptions() {
    return FirebaseOptions(
      appId: 'your_app_id',
      apiKey: 'your_api_key',
      projectId: 'your_project_id',
      messagingSenderId: 'your_messaging_sender_id',
      // You can add more configurations here as per your project's needs
    );
  }
}
```

#### **Use the configuration options in your application:**

- Now that you have the `firebase_options.dart` file, you can use it to provide the configuration options when initializing Firebase in `main.dart`.

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
```

#### By following these steps, you should have Firebase set up in your Flutter project and be ready to utilize its services in your mobile application.
