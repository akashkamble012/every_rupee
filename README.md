# ZBudget — Zero-Based Budget Tracker

An offline-first Flutter app that replicates and supercharges your 3-sheet
Zero-Based Budgeting spreadsheet.

---

## Architecture

```
lib/
├── core/
│   ├── di/             ← get_it + injectable DI graph
│   ├── router/         ← go_router with auth/onboarding gatekeeper
│   ├── theme/          ← AppDesign (OLED tokens, typography, colors)
│   ├── utils/          ← Formatters, logger
│   ├── error/          ← AppError sealed class
│   └── notifications/  ← SMS listener + auto-categorization
├── data/
│   ├── datasources/
│   │   ├── local/      ← Isar CRUD datasources
│   │   └── remote/     ← Firebase Auth + Firestore sync service
│   ├── models/isar/    ← Isar collection schemas
│   └── repositories/   ← Repository implementations
├── domain/
│   ├── entities/       ← Freezed immutable domain models
│   ├── repositories/   ← Abstract interfaces + Result<T> type
│   └── usecases/       ← Business logic use cases
└── presentation/
    ├── blocs/          ← flutter_bloc BLoCs (Auth, Dashboard, Ledger)
    ├── screens/        ← All screens
    └── widgets/        ← Reusable widgets (charts, tiles, filters)
```

---

## Setup

### 1. Flutter dependencies

```bash
flutter pub get
```

### 2. Code generation (Isar schema + Freezed + Injectable)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Firebase setup (requires Firebase CLI)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase project (creates google-services.json automatically)
flutterfire configure
```

This command will:
- Create `android/app/google-services.json`
- Create `ios/Runner/GoogleService-Info.plist`
- Create `lib/firebase_options.dart`

Update `bootstrap.dart` to use the generated options:
```dart
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
```

### 4. Android SHA-1 for Google Sign-In

```bash
# Debug SHA-1
cd android && ./gradlew signingReport
```

Add the SHA-1 fingerprint to your Firebase Console under:
Project Settings → Your Android app → Add fingerprint

### 5. Run

```bash
flutter run
```

---

## Key Features

| Feature | Implementation |
|---------|---------------|
| Offline-first DB | Isar (sub-5ms reads) |
| Cloud backup | Firestore (Last Write Wins sync) |
| SMS auto-capture | `telephony` package (background isolate) |
| Auto-categorization | Keyword dictionary → active BudgetCategoryEntity |
| Temporal caps | `activeUntil` date field — EMIs expire automatically |
| Temporal income | `effectiveFrom` / `effectiveUntil` — salary changes safe |
| Dual transactions | Debit deducts caps; Credit/Refund replenishes |
| Zero-based math | `CalculateMonthlySurplusUseCase` |
| Wealth trend chart | `fl_chart` sparkline — Column G from spreadsheet |
| Action Plan | SharedPreferences per month — Column H from spreadsheet |

---

## Firestore Security Rules (paste into Firebase Console)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      match /transactions/{txId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /categories/{catId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /incomeSources/{srcId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

---

## Screens

1. **Auth** — Email/Password + Google Sign-In
2. **Onboarding** — 4-slide PageView (ZBB rules)
3. **Budget Setup** — Zero-based form with sticky math tracker
4. **Dashboard** — Month navigator, macro card, wealth trend, action plan, donut chart, variance tiles, recent transactions
5. **Ledger** — Paginated list (chunks of 20), full filter sheet (date/category/type/search), swipe-to-delete
6. **Caps Manager** — Budget categories + income sources CRUD with expiry dates
7. **Settings** — Sign out, manual sync

---

## Roadmap / TODOs

- [ ] Run `build_runner` to generate `injection.config.dart`, Freezed files, Isar schemas
- [ ] Wire `firebase_options.dart` into `bootstrap.dart`
- [ ] Add `WealthHistoryRepository` to persist monthly snapshots for real trend data
- [ ] iOS: use `flutter_sms_inbox` instead of `telephony` (iOS has no background SMS)
- [ ] Add biometric lock (local_auth)
- [ ] Export CSV from ledger
