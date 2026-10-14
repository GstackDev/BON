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

The ready-to-host Flutter web build is in the repository root. In the GitHub
repository, open **Settings → Pages**, select **Deploy from a branch**, then
choose `master` and `/(root)`. GitHub Pages will serve the root `index.html`
and its JavaScript and asset files at <https://gstackdev.github.io/BON/>.

When updating the app, rebuild with
`flutter build web --release --base-href /BON/` and copy the contents of
`build/web` into the repository root before pushing.

## Notes

This project is structured as a starter for a voice effect processor with audio routing, DSP controls, and recording support.

### Included UI

- Home dashboard with live audio meter and quick controls
- Voice engine screen with gain, mix, pitch, and formant controls
- Recorder screen with start/stop capture actions
- Advanced DSP screen for sustain, room, saturation, and limiter tuning
- Settings screen for system audio preferences
