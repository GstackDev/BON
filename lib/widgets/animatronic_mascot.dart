import 'package:flutter/material.dart';

class AnimatronicMascot extends StatelessWidget {
  const AnimatronicMascot({super.key});

  @override
  Widget build(BuildContext context) {
    const steel = Color(0xFFC2A77E);
    const darkMetal = Color(0xFF32271F);
    const led = Color(0xFFFFB547);

    return SizedBox(
      width: 150,
      height: 158,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 142,
            height: 142,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  led.withValues(alpha: 0.20),
                  const Color(0xFF101820).withValues(alpha: 0),
                ],
              ),
            ),
          ),
          Positioned(
            top: 17,
            left: 14,
            child: _ear(darkMetal: darkMetal),
          ),
          Positioned(
            top: 17,
            right: 14,
            child: _ear(darkMetal: darkMetal),
          ),
          Positioned(
            top: 25,
            child: Container(
              width: 108,
              height: 117,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(38),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFD1AC76), Color(0xFF96704A), Color(0xFF59412F)],
                  stops: [0.0, 0.48, 1.0],
                ),
                border: Border.all(color: const Color(0xFFDCC49E), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x99000000),
                    blurRadius: 18,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x66FFB547),
                    blurRadius: 15,
                    spreadRadius: -5,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 56,
            left: 42,
            child: _eye(led: led, darkMetal: darkMetal),
          ),
          Positioned(
            top: 56,
            right: 42,
            child: _eye(led: led, darkMetal: darkMetal),
          ),
          Positioned(
            top: 84,
            child: Container(
              width: 61,
              height: 37,
              decoration: BoxDecoration(
                color: steel,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE5D3B7), width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Color(0x66000000), blurRadius: 7, offset: Offset(0, 4)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 82,
            child: Container(
              width: 22,
              height: 14,
              decoration: BoxDecoration(
                color: darkMetal,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: const Color(0xFF59412F)),
              ),
            ),
          ),
          Positioned(
            top: 112,
            child: Container(
              width: 49,
              height: 18,
              decoration: BoxDecoration(
                color: const Color(0xFF211C19),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color(0xFF4D3C2D), width: 1.5),
              ),
            ),
          ),
          for (var i = 0; i < 4; i++)
            Positioned(
              top: 113,
              left: 56 + i * 9,
              child: Container(
                width: 7,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8DDC9),
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
          for (final position in const [
            Offset(31, 46),
            Offset(109, 46),
            Offset(34, 107),
            Offset(106, 107),
          ])
            Positioned(
              left: position.dx,
              top: position.dy,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF30251D),
                  boxShadow: [BoxShadow(color: Color(0x99E5C391), blurRadius: 2)],
                ),
              ),
            ),
          Positioned(
            top: 4,
            child: Container(
              width: 44,
              height: 17,
              decoration: BoxDecoration(
                color: const Color(0xFF27221E),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color(0xFFB28A57), width: 1.5),
              ),
              child: const Center(
                child: Text(
                  'BV',
                  style: TextStyle(
                    color: Color(0xFFFFC15E),
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ear({required Color darkMetal}) {
    return Container(
      width: 43,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD1AC76), Color(0xFF96704A), Color(0xFF59412F)],
        ),
        border: Border.all(color: const Color(0xFFDCC49E), width: 2),
        boxShadow: const [BoxShadow(color: Color(0x88000000), blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Center(
        child: Container(
          width: 23,
          height: 24,
          decoration: BoxDecoration(
            color: darkMetal,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFB08A5A), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _eye({required Color led, required Color darkMetal}) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: darkMetal,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF3D3127), width: 2),
        boxShadow: [
          BoxShadow(color: led.withValues(alpha: 0.62), blurRadius: 13, spreadRadius: 1),
        ],
      ),
      child: Center(
        child: Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: led,
            boxShadow: [BoxShadow(color: led.withValues(alpha: 0.85), blurRadius: 8)],
          ),
        ),
      ),
    );
  }
}
