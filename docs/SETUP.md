# Setup guide

## Prerequisites

- Flutter **stable** (SDK constraint in `pubspec.yaml`: `^3.8.1`)
- Chrome (or Edge) for web development
- Git

Verify:

```bash
flutter doctor -v
flutter --version
```

## Install

```bash
git clone <repo-url>
cd StepZero
flutter pub get
```

## Run

```bash
flutter run -d chrome
# or
flutter run -d web-server --web-port 8080
```

## Quality gates (required before PR)

```bash
flutter analyze
flutter test
flutter build web --release
```

## IDE

- Enable Dart / Flutter plugins
- Prefer absolute imports within `lib/`
- Format with `dart format .`

## Environment defines

Optional analytics (see README). Example `.vscode/launch.json` args:

```json
{
  "args": [
    "--dart-define=GA_MEASUREMENT_ID=G-XXXX"
  ]
}
```

## Contact backend

Default: `MockContactRepository` (simulated latency + honeypot).

To connect production:

1. Implement `ContactRepository` HTTP client.
2. Inject via `ContactRepositoryImpl(delegate: YourApi())`.
3. Keep honeypot + validators client-side; add server-side spam checks.

## Common issues

| Symptom | Fix |
|---|---|
| Blank page on refresh | Ensure host SPA rewrite → `index.html` |
| Fonts missing | Confirm `assets/fonts/Inter-Variable.ttf` in pubspec |
| Analyze fails on web-only libs | Conditional imports already used for SEO/analytics |
