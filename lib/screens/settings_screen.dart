import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const _defaults = <String, bool>{
    'micMonitoring': true,
    'noiseSuppression': true,
    'studioMode': false,
    'adaptiveGain': true,
  };

  late Map<String, bool> _settings = Map.of(_defaults);
  SharedPreferences? _preferences;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      if (!mounted) return;
      setState(() {
        _preferences = preferences;
        _settings = {
          for (final entry in _defaults.entries)
            entry.key: preferences.getBool('settings.${entry.key}') ?? entry.value,
        };
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showMessage('Could not load settings: $error');
    }
  }

  Future<void> _updateSetting(String key, bool value) async {
    final previousValue = _settings[key]!;
    setState(() => _settings[key] = value);
    try {
      final saved = await _preferences!.setBool('settings.$key', value);
      if (!saved) throw StateError('The setting was not saved.');
    } catch (error) {
      if (!mounted) return;
      setState(() => _settings[key] = previousValue);
      _showMessage('Could not save setting: $error');
    }
  }

  Future<void> _resetSettings() async {
    final previousSettings = Map<String, bool>.of(_settings);
    setState(() => _settings = Map.of(_defaults));
    try {
      final results = await Future.wait(
        _defaults.entries.map(
          (entry) => _preferences!.setBool('settings.${entry.key}', entry.value),
        ),
      );
      if (results.any((saved) => !saved)) {
        throw StateError('One or more settings could not be saved.');
      }
      if (mounted) _showMessage('Settings restored to default.');
    } catch (error) {
      if (!mounted) return;
      setState(() => _settings = previousSettings);
      _showMessage('Could not reset settings: $error');
    }
  }

  void _handleInstallPressed() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.install_mobile_rounded),
          title: const Text('Install Bon Voice'),
          content: const Text(
            'Use your browser’s install menu to add Bon Voice to your device. '
            'The install option appears when your browser supports it.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      children: [
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Make your voice setup feel right.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white60,
              ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF674525), Color(0xFF25231F), Color(0xFF1C2022)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF9B7544)),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.phone_iphone_rounded, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Take Bon Voice with you',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Add the app to your device for quick access.',
                style: TextStyle(color: Colors.white70, height: 1.4),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _handleInstallPressed,
                icon: const Icon(Icons.download_rounded),
                label: const Text('How to install'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFC8A46D)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSection(
          title: 'Input',
          children: [
            _buildSettingTile(
              key: const ValueKey('setting-micMonitoring'),
              icon: Icons.mic_none_rounded,
              title: 'Mic monitoring',
              subtitle: 'Hear your voice while you speak',
              settingKey: 'micMonitoring',
            ),
            _buildSettingTile(
              key: const ValueKey('setting-noiseSuppression'),
              icon: Icons.graphic_eq_rounded,
              title: 'Noise suppression',
              subtitle: 'Reduce background noise',
              settingKey: 'noiseSuppression',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildSection(
          title: 'Output',
          children: [
            _buildSettingTile(
              key: const ValueKey('setting-studioMode'),
              icon: Icons.speaker_group_rounded,
              title: 'Studio monitor',
              subtitle: _settings['studioMode']!
                  ? 'Studio monitor selected'
                  : 'Phone speaker selected',
              settingKey: 'studioMode',
            ),
            _buildSettingTile(
              key: const ValueKey('setting-adaptiveGain'),
              icon: Icons.tune_rounded,
              title: 'Adaptive gain',
              subtitle: _settings['adaptiveGain']! ? 'Adjust automatically' : 'Manual levels',
              settingKey: 'adaptiveGain',
            ),
          ],
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: _resetSettings,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Reset to defaults'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            foregroundColor: Colors.white70,
            side: const BorderSide(color: Colors.white24),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 10),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Material(
          color: const Color(0xFF191D1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF51432F)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required Key key,
    required IconData icon,
    required String title,
    required String subtitle,
    required String settingKey,
  }) {
    final value = _settings[settingKey]!;
    return SwitchListTile(
      key: key,
      value: value,
      onChanged: (nextValue) => _updateSetting(settingKey, nextValue),
      secondary: Icon(icon, color: const Color(0xFFFFB547)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60)),
      activeThumbColor: const Color(0xFFFFB547),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    );
  }
}
