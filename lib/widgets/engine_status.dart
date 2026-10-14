import 'package:flutter/material.dart';

class EngineStatus extends StatelessWidget {
  final bool active;

  const EngineStatus({required this.active, super.key});

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF4ADE80) : const Color(0xFF7D8796);

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.5),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          active ? 'Engine running' : 'Engine idle',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
