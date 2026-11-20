# Eskan

Real estate app for sale and rent. Arabic-first (ar_EG), Firebase-backed.

**Project:** Real estate listing application for the Egyptian market.
**Features:** Property listings (sale/rent), search/filter, favorites, user properties.
**Stack:** Flutter, GetX, Firebase (Auth, Firestore, Storage), OneSignal push notifications.

---

## 🚀 AI Agent & Package Setup

See [AI_SETUP.md](AI_SETUP.md) for the full research on:

- **Coding-agent skills** installed from `flutter/agent-plugins` (25 skills) and
  `dart-lang/skills` (15 skills) into `.agents/skills/` — teaches AI assistants
  correct Flutter/Dart patterns for this project.
- **In-app AI packages** assessed for the property chat/search feature
  (`firebase_ai`, `flutter_gen_ai_chat_ui`, `flutter_ai_toolkit`, Genkit Dart,
  LangChain.dart, `openai_dart`, `flutter_chat_ui`, `widget_chat`) — with a
  recommended path that waits for a controlled Firebase upgrade first.

### Skills Installed

This project uses agent skills from:

```bash
npx skills add flutter/agent-plugins --skill '*' --agent universal --yes
npx skills add dart-lang/skills --skill '*' --agent universal --yes
```

Run from the project root to reinstall or update. Skills live in `.agents/skills/`.

---

## 📁 Project Structure

Follows a modified MVVM architecture with GetX for state management:

```
lib/
├── controllers/       # GetX controllers (ViewModels)
│   └── used/         # Controller implementations
├── models/           # Data models with JSON serialization
│   └── used/         # Model implementations
├── services/         # Firebase services (Data layer)
│   └── PropertyServices.dart
├── views/            # UI layer (Widgets & Screens)
│   ├── compunants/   # Reusable widgets
│   ├── screens/      # Full-screen views
│   └── used/         # Additional views
├── utills/           # Utilities (theme, config, toast, colors)
├── l10n/             # Localization files (ARB format)
├── main.dart         # App entry point
└── previews.dart     # Widget previews for development
```

---

## 🛠️ Development Setup

### Prerequisites

- Flutter SDK (>=3.0.3, <4.0.0)
- Dart (>=3.0.3)
- Firebase project configured

### Install Dependencies

```bash
flutter pub get
```

### Run the App

```bash
flutter run
```

### Run Tests

```bash
# Run all tests
flutter test

# Run widget tests only
flutter test test/widget_test/

# Run integration tests
flutter test integration_test/app_test.dart
```

### Generate Assets

```bash
# Generate launcher icons
dart run flutter_launcher_icons

# Generate native splash screen
dart run flutter_native_splash:create

# To remove splash screen
dart run flutter_native_splash:remove
```

### Widget Previews

Widget previews are available in `lib/views/compunants/previews.dart`.
Use Flutter Widget Previewer in supported IDEs (Android Studio, IntelliJ, VS Code with Flutter 3.47+).

---

## ✨ Key Features

### Property Management
- Add properties with images, details, and pricing
- Support for both sale and rental listings
- Image upload to Firebase Storage
- Property validation before saving

### Search & Filtering
- Search by area name
- Filter by city
- Price range filtering
- Server-side query optimization

### User Features
- User authentication (Google Sign-In, phone)
- Favorites management
- View own property listings
- Account settings

### UI/UX
- Arabic-first RTL support (ar_EG locale)
- Material Design 3 theming
- Light/dark mode with persistence
- Responsive layouts for tablets/desktops
- Carousel for featured properties
- Bottom navigation with PageView

### Push Notifications
- OneSignal integration
- Push notification permission handling

---

## 🧪 Testing

### Widget Tests

Located in `test/widget_test/`:

| Test File | Description |
|-----------|-------------|
| `models_test.dart` | PropertyModel tests |
| `city_model_test.dart` | CityModel tests |
| `category_model_test.dart` | Category model tests |
| `property_image_view_test.dart` | Image component tests |
| `search_button_test.dart` | SearchButton tests |
| `rent_view_card_test.dart` | Property card tests |
| `theme_controller_test.dart` | ThemeController tests |

### Integration Tests

Located in `test/integration_test/`:
- `app_test.dart` - End-to-end app flow tests

Run with:
```bash
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```

---

## 🔍 Code Quality

### Static Analysis

```bash
# Run analyzer
dart analyze .

# Auto-fix issues
dart fix --apply

# Format code
dart format .
```

Configuration: `analysis_options.yaml`

### Lint Rules

Enabled rules:
- `avoid_shadowing_type_parameters`
- `await_only_futures`
- `use_super_parameters`
- `prefer_const_constructors`
- `prefer_const_declarations`
- `avoid_empty_else`
- `cancel_subscriptions`
- `close_sinks`
- `test_types_in_equals`
- `throw_in_finally`
- `use_key_in_test_expects`

Strict mode:
- `strict-casts: true`
- `strict-inference: true`
- `strict-raw-types: true`

---

## 📱 Localization

Arabic (ar_EG) is the primary locale.

ARB files: `lib/l10n/app_ar.arb`

For adding new languages:
1. Create `lib/l10n/app_<locale>.arb`
2. Update `l10n.yaml` if needed
3. Update supported locales in `main.dart`

See [AI_SETUP.md](AI_SETUP.md) for localization migration guide to ARB-based approach.

---

## 🔧 Configuration

### Environment Variables

Configuration is in `lib/utills/app_config.dart`:

```dart
class AppConfig {
  static const onesignalAppId = '0183cc36-fb23-4be7-89ed-d3b112693d01';
  static const businessPhoneNumber = '+201112243628';
}
```

### Firebase Setup

Run `flutterfire configure` to set up Firebase options, or manually edit `lib/firebase_options.dart`.

---

## 🎨 Theming

Color schemes defined in `lib/utills/themes.dart`:

- **Light Theme:** Blue primary (`#00658D`), white background
- **Dark Theme:** Light blue primary (`#83CFFF`), dark background (`#191C1E`)

Custom colors in `lib/utills/customColors.dart`:
- `prime_color`: `#0084D1` (primary blue)
- `secondary_color`: `#008BE6` (secondary blue)
- `green_color`: `#008BE6` (action green)
- `coral_Color`: `#008BE6` (accent)

---

## 📊 Firebase Collections

| Collection | Description |
|------------|-------------|
| `property` | Property listings with images, details, pricing |
| `city` | City names for dropdown filters |
| `catogry` | Property categories/types |

Storage path: `RealState/`

---

## 🔄 State Management

Uses **GetX** for:
- Dependency injection (`Get.put`, `Get.find`)
- Reactive state (`.obs` variables, `Obx` widgets)
- Navigation (`Get.to`, `Get.offAll`)
- Local storage (`GetStorage`)

Bindings configured in `lib/utills/app_bindings.dart`.

---

## 📦 Future Enhancements

### AI Features (Planned)

When Firebase is upgraded to v5/v7:
1. Add `firebase_ai: ^5.2.0`
2. Add `firebase_app_check: ^0.5.1`
3. Add `flutter_gen_ai_chat_ui: ^2.22.0` for Arabic-ready chat UI

See [AI_SETUP.md](AI_SETUP.md) for detailed research.

### Potential Improvements

- [ ] Migrate to ARB-based localization (`flutter_localizations` + `intl`)
- [ ] Add GoRouter for declarative routing
- [ ] Implement repository pattern for data layer
- [ ] Add more comprehensive test coverage
- [ ] CI/CD pipeline setup
- [ ] Performance optimization (lazy loading, caching)

---

## 📄 License

Private project - not published to pub.dev.
