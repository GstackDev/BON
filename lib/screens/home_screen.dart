import 'package:flutter/material.dart';

import '../services/audio_service.dart';
import '../services/preset_service.dart';
import '../services/permission_service.dart';
import '../widgets/animatronic_mascot.dart';
import '../widgets/audio_meter.dart';
import '../widgets/engine_status.dart';
import '../widgets/preset_card.dart';
import '../widgets/quick_control.dart';
import 'advanced_screen.dart';
import 'recorder_screen.dart';
import 'settings_screen.dart';
import 'voice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService _audioService = AudioService();
  final PresetService _presetService = PresetService();
  final PermissionService _permissionService = PermissionService();
  int _selectedIndex = 0;
  String _selectedPresetId = 'bon_style';
  bool _micEnabled = false;
  bool _monitorEnabled = false;

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      _buildHomePanel(),
      const VoiceScreen(),
      const RecorderScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bon Voice'),
        actions: [
          IconButton(
            tooltip: 'Advanced audio settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const AdvancedScreen()),
              );
            },
            icon: const Icon(Icons.tune_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(child: screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.mic_rounded), label: 'Voice'),
          BottomNavigationBarItem(icon: Icon(Icons.mic_external_on_rounded), label: 'Recorder'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildHomePanel() {
    final presets = _presetService.presets;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF080A0D), Color(0xFF171511), Color(0xFF0C1116)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        children: [
          const SizedBox(height: 8),
          _buildStageBanner(),
          const SizedBox(height: 16),
          AudioMeter(value: _audioService.state.inputGain),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF191A1A),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF75552F).withValues(alpha: 0.55)),
            ),
            child: EngineStatus(active: _audioService.isEngineRunning),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              QuickControl(
                icon: Icons.mic_none_rounded,
                label: 'Mic',
                active: _micEnabled,
                onPressed: () async {
                  if (_micEnabled) {
                    setState(() {
                      _micEnabled = false;
                      _audioService.stopEngine();
                      _monitorEnabled = false;
                    });
                    return;
                  }
                  final ok = await _permissionService.requestMicPermission();
                  if (!mounted) return;
                  setState(() {
                    _micEnabled = ok;
                    if (ok) {
                      _audioService.startEngine();
                    }
                  });
                },
              ),
              const SizedBox(width: 12),
              QuickControl(
                icon: Icons.volume_up_rounded,
                label: 'Monitor',
                active: _monitorEnabled,
                onPressed: () => setState(() {
                  _monitorEnabled = !_monitorEnabled;
                  _audioService.setOutputGain(_monitorEnabled ? 0.8 : 0.0);
                }),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              const Expanded(
                child: Text('Presets', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              ),
              Text(
                '${presets.length} profiles',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(presets.length, (index) {
              final preset = presets[index];
              const accentPalette = [
                Color(0xFFD39A55),
                Color(0xFF8C9CA3),
                Color(0xFFC66B50),
                Color(0xFFB79A70),
              ];
              final accent = accentPalette[index % 4];
              final selected = preset.id == _selectedPresetId;

              return PresetCard(
                name: preset.name,
                accent: accent,
                selected: selected,
                onTap: () {
                  setState(() {
                    _selectedPresetId = preset.id;
                    _audioService.setInputGain((preset.values['gain'] ?? 0.5).toDouble());
                    _audioService.setOutputGain(0.7);
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStageBanner() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mascotWidth = constraints.maxWidth < 360 ? 112.0 : 138.0;

        return Container(
          height: 174,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF29231B), Color(0xFF14191C), Color(0xFF101317)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF9B7544).withValues(alpha: 0.75)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x443C2811),
                blurRadius: 22,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF392B1D),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF80603A)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, size: 7, color: Color(0xFFFFB547)),
                          SizedBox(width: 6),
                          Text(
                            'VOICE UNIT 01',
                            style: TextStyle(
                              color: Color(0xFFFFD08A),
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'READY FOR\nTHE SPOTLIGHT',
                      style: TextStyle(
                        color: Color(0xFFF5EBDD),
                        fontSize: 20,
                        height: 1.08,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'ANIMATRONIC VOICE SYSTEM',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFFC0A982),
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: mascotWidth,
                height: 150,
                child: const AnimatronicMascot(),
              ),
            ],
          ),
        );
      },
    );
  }
}
