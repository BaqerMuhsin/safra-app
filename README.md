# Safra · سفره

A Flutter app for discovering and booking tourist trips inside Iraq — from the mountains of Kurdistan to the southern marshes and the holy shrines. Travelers browse trips from local tour companies, reserve seats in a few taps, and manage their bookings in one place.

The interface is Arabic-first and fully right-to-left.

> **Status: UI prototype.** Every screen is implemented and navigable, but the app runs on in-memory sample data. There is no backend yet: sign-in accepts any valid Iraqi number and any 6-digit code, bookings are not persisted between launches, and no payment is processed. See [Roadmap](#roadmap).

## Features

| Area | What the traveler can do |
| --- | --- |
| **Sign in** | Enter an Iraqi mobile number (`+964`), confirm with a 6-digit code, resend the code after a countdown |
| **Home** | Browse trips grouped by region — North, Holy Shrines, South, Nature — in horizontal carousels |
| **Search** | Search by destination, trip or company name and filter by category |
| **Trip details** | Photo, duration, date, seats left, organizer, highlights, day-by-day itinerary, what's included, meeting point |
| **Booking** | Choose the number of travelers, enter the lead traveler's name, pick a payment method, review the price, confirm |
| **My trips** | Upcoming and past bookings, booking details with reference number, cancel an upcoming booking |
| **Companies** | Searchable directory of tour companies, each with a profile, contact details and its trips |
| **Notifications** | Booking confirmations, reminders and offers with unread indicators |
| **More** | Profile editing, support contacts, terms and conditions, about, sign out |

## Tech stack

- **Flutter** (Dart SDK `^3.11.4`), Material 3
- **GetX** for state management, dependency injection and routing
- **HugeIcons** (stroke-rounded set) for iconography
- **Somar Sans** for body text and **El Messiri** for headings, bundled in `assets/fonts`
- `flutter_localizations` with the app locale fixed to Arabic (`ar`)

## Getting started

### Prerequisites

- Flutter 3.41 or newer (`flutter --version`)
- Xcode for iOS, or Android Studio / the Android SDK for Android
- Access to the OnePub package host that serves `hugeicons` (see below)

### Install and run

```bash
flutter pub get
```

```bash
flutter run
```

### The `hugeicons` dependency

`hugeicons` is resolved from a private OnePub host, not pub.dev:

```yaml
hugeicons:
  hosted: https://onepub.dev/api/kdpxxpsdav/
  version: ^1.1.7
```

`flutter pub get` fails on a machine that has not been granted access to that host. Authenticate with OnePub first (`dart pub global activate onepub`, then `onepub login`).

### iOS builds on recent Xcode

The iOS project's deployment target is 13.0. Recent Xcode releases only accept 15.0 or newer and stop the build with a "Target Integrity" error. Raise `IPHONEOS_DEPLOYMENT_TARGET` in `ios/Runner.xcodeproj` to 15.0 if you hit it.

## Project structure

```
lib/
├── main.dart                 App entry: theme, locale, routes
├── app/
│   ├── bindings/             App-wide service registration
│   └── routes/               Route names and page table
├── core/
│   ├── services/             Trips, bookings, notifications, session
│   ├── theme/                Colors, typography, component themes
│   ├── utils/                Arabic formatters, snackbars, bottom sheets
│   └── widgets/              Shared widgets (cards, headers, fields, chips…)
├── data/
│   ├── models/               Trip, Company, Booking, AppNotification
│   └── mock_data.dart        Sample trips, companies and notifications
└── modules/                  One folder per feature
    ├── login/
    ├── home/                 Shell with the four tabs and bottom navigation
    ├── trips_list/           Search and category listing
    ├── trip_details/
    ├── company_details/
    ├── booking/              Checkout, confirmation, booking details
    ├── notifications/
    ├── profile/
    └── terms/
```

Each feature module follows the GetX layout of `bindings/`, `controllers/` and `views/`. Screens that can appear more than once in the navigation stack (trip and company details) receive their subject through the constructor instead of a shared controller.

### Navigation

| Route | Screen |
| --- | --- |
| `/login` | Phone and OTP sign-in |
| `/home` | Tab shell: Home, My trips, Companies, More |
| `/trips` | Search and category listing |
| `/trip` | Trip details |
| `/company` | Company profile |
| `/booking` | Checkout |
| `/booking/success` | Booking confirmation |
| `/booking/details` | A single booking |
| `/notifications` | Notifications |
| `/profile` | Edit profile |
| `/terms` | Terms and conditions |

## Design system

Colors, radii and text styles live in `lib/core/theme/app_theme.dart`.

| Token | Value | Use |
| --- | --- | --- |
| `primary` | `#0077B6` | Brand blue: buttons, active states, links |
| `secondary` | `#FF6B6B` | Prices, badges, accents |
| `background` | `#F6F6F6` | Screen background |
| `surface` | `#FFFFFF` | Cards and inputs |
| `textStrong` | `#1F1F1F` | Headings and primary text |
| `textBody` | `#6B7280` | Body text |

Cards and inputs share an 18px corner radius and a 1px `#E6E6EA` border. Build new screens from the widgets in `lib/core/widgets` so they stay consistent.

## Testing

```bash
flutter test
```

`test/app_flow_test.dart` drives the whole app at two phone sizes: it signs in, books a trip, and opens every screen, failing on any exception or layout overflow.

```bash
flutter analyze
```

## Roadmap

- Connect a backend API; `TripsService` and `BookingsService` are the seams where `MockData` is replaced
- Real OTP delivery and a persisted session
- Online payment (ZainCash and card) — the payment choice is currently recorded but not charged
- Replace the placeholder support and company contact details and the stock trip photos
- Push notifications
- Additional languages (English, Kurdish)
