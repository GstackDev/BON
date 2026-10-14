import 'package:flutter/material.dart';

class QuickControl extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onPressed;

  const QuickControl({
    required this.icon,
    required this.label,
    this.active = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 22),
          decoration: BoxDecoration(
            color: active ? theme.colorScheme.primary.withValues(alpha: 0.18) : const Color(0xFF1C2022),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: active ? theme.colorScheme.primary.withValues(alpha: 0.7) : const Color(0xFF574A37),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: (active ? theme.colorScheme.primary : Colors.black).withValues(alpha: active ? 0.2 : 0.12),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 31,
                color: active ? theme.colorScheme.primary : const Color(0xFFD4C8B8),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                  fontSize: 15,
                  color: active ? Colors.white : const Color(0xFFD4C8B8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
