# Flutter BrightHR 

## Description

Flutter BrightHR application is a cross-platform mobile application designed to Show Case bloc architecture with API data. It supports both Android and iOS platforms and offers features such as List and List Detail displayed.

## Features

- Cross-platform support for Android and iOS
- List & List Detail
- Portrait and Landscape UI manage
- Badge Count

## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (for Flutter-based apps)
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/) for development

### Clone the Repository

git clone https://github.com/AkashMatlani/flutter_bright_hr
cd your-repository

Android Setup
1) Open the project in Android Studio.
2) Set up an Android emulator or connect an Android device.
3) Run the app
4) flutter run

iOS Setup
1) Open the ios folder in Xcode.
2) Set up an iOS simulator or connect an iOS device.
3) Run the app
4) flutter run

## Architectural Choices and Third-Party Packages

### Architectural Choices

Our application is built using the following architectural principles:
  **[Bloc](https://pub.dev/packages/flutter_bloc)**: 
  - **Reason**: BLoC (Business Logic Component) is a pattern for managing state and separating business logic from UI components. It is a widely adopted state management solution that works well with streams and reactive programming.
    
### Third-Party Packages

Here is a list of third-party packages used in our project along with the reasons for their inclusion:

 **[Bloc](https://pub.dev/packages/flutter_bloc)**: 
  - **Reason**: BLoC helps to create scalable and maintainable applications by organizing code into events, states, and business logic. It allows a clear separation of concerns between the UI and logic, making it easier to test and debug.

**[Dio](https://pub.dev/packages/dio)**: 
  - **Reason**: Dio is a powerful and flexible HTTP client for Dart, providing robust support for network requests, interceptors, global configurations, and response handling. It simplifies API communication with features like request cancellation, retries, and custom adapters, making it an excellent choice for handling RESTful APIs efficiently.

**[Connectivity Plus](https://pub.dev/packages/connectivity_plus)**: 
  - **Reason**: Connectivity Plus allows apps to monitor network connectivity status, including Wi-Fi, mobile data, and offline modes. It helps developers handle real-time connection changes and implement offline-first strategies, improving app reliability and user experience.

**[badges](https://pub.dev/packages/badges)**: 
  - **Reason**: Badges helps improve the user experience and interface design by allowing developers to display notification badges, counters, and other markers on icons or widgets in Flutter apps. This enhances UI by visually indicating notifications, updates, or other important statuses to users in a clean and effective way.

**[shared_preferences](https://pub.dev/packages/shared_preferences)**: 
  - **Reason**: Provides a simple way to store small amounts of persistent data locally in key-value pairs. It allows developers to save and retrieve data such as user preferences, settings, and app state across sessions, improving user experience by maintaining a consistent state within the app even after it's closed or restarted. This package is ideal for storing lightweight information like user login sessions, theme preferences, and app configuration settings.

**[go_router](https://pub.dev/packages/go_router)**: 
  - **Reason**: Simplifies navigation and routing in Flutter apps by providing a declarative and flexible API. It supports deep linking, dynamic routing, nested routes, and URL-based navigation, making it easier to manage complex navigation flows. With built-in support for state restoration and URL synchronization, it allows developers to create web-like navigation experiences in Flutter apps, improving both developer productivity and app maintainability.
    
### How to Add/Update Packages

To add or update packages in the project, follow these steps:

1. **Add to `pubspec.yaml`**:
   - Open the `pubspec.yaml` file and add the desired package under dependencies.

2. **Install Packages**:
   - Run `flutter pub get` in the terminal to fetch the new dependencies.

3. **Update Usage**:
   - Import the package into your Dart files and update the code to utilize the new functionality.
