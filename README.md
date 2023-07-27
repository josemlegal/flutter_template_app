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
1. Clone the repo, and get the packages.
2. Create your own project on the [Firebase Console](https://console.firebase.google.com/) or select an existing one.
3. Create the `firebase_options.dart` file: To generate this file you should follow this [youtube tutorial](https://www.youtube.com/watch?v=G-mbqiE87Lw&ab_channel=HeyFlutter%E2%80%A4com) or check this [documentation](https://firebase.google.com/docs/flutter/setup?platform=ios).
4. Add the sha1 and sha256 fingerprints in your firebase console in general settings.
   ![image](https://github.com/josemlegal/flutter_template_app/assets/96390036/6beb53f3-267a-4174-9c7e-1e0082796b5a)
   
To generate the fingerprints run this command in your terminal.

#### Linux/macOs:

`keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android`
#### Windows:

`keytool -list -v -alias androiddebugkey -keystore  %USERPROFILE%\.android\debug.keystore`




#### By following these steps, you should have Firebase set up in your Flutter project and be ready to utilize its services in your mobile application.
