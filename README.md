# a199-flutter-expert-project

[![Codemagic build status](https://api.codemagic.io/apps/63957feafbe52cdbad81d0fd/android/status_badge.svg)](https://codemagic.io/apps/63957feafbe52cdbad81d0fd/android/latest_build)

---

## Screenshot CI & Firebase

| CI Codemagic | Firebase Crashlytics | Firebase Analytics | 
|--------------|----------------------|--------------------|
|![ss_ci](./screenshot/ss_ci.png)|![ss_firebase](./screenshot/ss_firebase.png)| ![ss_firebase_analytics](./screenshot/ss_analytics_firebase.png)|



---

run in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run 
```

## Build App 🔥

To build APK use the following commands:

```sh
$ flutter build apk 
```

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ ./test.sh
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov)
.

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```
