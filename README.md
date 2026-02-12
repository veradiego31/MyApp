# MyApp

Native iOS/macOS app built with **SwiftUI** and **Swift**. Targets iOS 17.0+ and supports both iPhone and iPad. The project uses only Apple frameworks (no external dependencies).

## Requirements

- Xcode 16 or later
- iOS 17.0+ simulator or device
- macOS compatible with your Xcode version

## Getting Started

### Open in Xcode

1. Clone the repository.
2. Open `MyApp.xcodeproj` in Xcode.
3. Select the `MyApp` scheme.
4. Choose an iOS Simulator (for example, iPhone 16).
5. Press **Run** to build and launch the app.

### Build from the command line

You can also build using `xcodebuild`:

```bash
# Build
xcodebuild -project MyApp.xcodeproj -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 16' build
```

## Running Tests

Run all tests:

```bash
xcodebuild -project MyApp.xcodeproj -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 16' test
```

Run only UI tests:

```bash
xcodebuild -project MyApp.xcodeproj -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:MyAppUITests test
```

Run only unit tests:

```bash
xcodebuild -project MyApp.xcodeproj -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:MyAppTests test
```

## Project Structure

- `MyApp/MyAppApp.swift` – App entry point (`@main`), creates a `WindowGroup` loading `ContentView`.
- `MyApp/ContentView.swift` – Root view with the main UI layout.
- `MyAppTests/` – XCTest unit tests (`@testable import MyApp`).
- `MyAppUITests/` – XCTest UI tests using `XCUIApplication`.

## Notes

- The UI is implemented in SwiftUI and follows Apple’s Human Interface Guidelines.
- The codebase is intended to showcase modern Swift and SwiftUI patterns with no third‑party dependencies.