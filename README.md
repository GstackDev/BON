# bon-voice

A lightweight Flutter app for voice transformation, audio monitoring, presets, and recording.

## Structure

- `lib/` contains the app UI and core logic
- `android/` contains Android-native audio bridge stubs
- `presets/` contains default voice profiles in JSON

## Running

```bash
flutter pub get
flutter run
```

## Publish to GitHub Pages

This repository deploys the Flutter web app automatically when changes are
pushed to `master`. The workflow builds the release app with the `/BON/` base
path and publishes `build/web` to GitHub Pages.

1. In the GitHub repository, open **Settings → Pages**.
2. Set **Build and deployment → Source** to **GitHub Actions**.
3. Push a commit to `master`, or run **Deploy Bon Voice to GitHub Pages**
   manually from the **Actions** tab.
4. Open <https://gstackdev.github.io/BON/> after the Pages deployment succeeds.

Do not publish the Flutter source folder as a static site. GitHub Actions builds
the required HTML, JavaScript, and asset files for you.

## Notes

This project is structured as a starter for a voice effect processor with audio routing, DSP controls, and recording support.

### Included UI

- Home dashboard with live audio meter and quick controls
- Voice engine screen with gain, mix, pitch, and formant controls
- Recorder screen with start/stop capture actions
- Advanced DSP screen for sustain, room, saturation, and limiter tuning
- Settings screen for system audio preferences
