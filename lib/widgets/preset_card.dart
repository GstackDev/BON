import 'package:flutter/material.dart';

class PresetCard extends StatelessWidget {
  final String name;
  final Color accent;
  final bool selected;
  final VoidCallback? onTap;

  const PresetCard({
    required this.name,
    required this.accent,
    this.selected = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final active = selected ? const Color(0xFFFFE9C5) : const Color(0xFFC8BEB0);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.lerp(const Color(0xFF292823), accent, selected ? 0.48 : 0.25)!,
              Color.lerp(const Color(0xFF14181A), accent, selected ? 0.23 : 0.10)!,
            ],
          ),
          border: Border.all(
            color: selected ? accent.withValues(alpha: 0.95) : accent.withValues(alpha: 0.42),
            width: selected ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: selected ? 0.20 : 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: active,
                    ),
                  ),
                ),
                if (selected)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              selected ? 'Active profile' : 'Voice profile',
              style: TextStyle(
                color: active,
                fontSize: 12,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
