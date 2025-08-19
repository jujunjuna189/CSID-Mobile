import 'package:flutter/material.dart';

class AnimationShimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double speed; // multiplier kecepatan
  final Duration delay;
  final double maxOpacity;
  final double startHiddenFraction; // seberapa jauh awal shimmer tersembunyi (0.0 - 1.0)

  const AnimationShimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.speed = 2.0,
    this.delay = const Duration(milliseconds: 300),
    this.maxOpacity = 0.5,
    this.startHiddenFraction = 0.2,
  });

  @override
  State<AnimationShimmer> createState() => _AnimationShimmerState();
}

class _AnimationShimmerState extends State<AnimationShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _startLoop();
  }

  void _startLoop() async {
    while (mounted) {
      await _controller.forward(from: 0);
      await Future.delayed(widget.delay);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final width = bounds.width;
            final height = bounds.height;

            // eased value → lambat awal → cepat akhir
            final easedValue = Curves.easeIn.transform(_controller.value);

            // start shimmer lebih sembunyi
            final startOffset = -widget.startHiddenFraction * width;
            final dx = startOffset + (2 * width) * (easedValue * widget.speed) - width;

            // opacity redup → terang → redup
            final progress = _controller.value;
            final fade = progress <= 0.5 ? (progress * 2) : (2 - progress * 2);

            return LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white.withOpacity(0.0),
                Colors.white.withOpacity(widget.maxOpacity * fade),
                Colors.white.withOpacity(0.0),
              ],
              stops: const [0.35, 0.5, 0.65],
            ).createShader(
              Rect.fromLTWH(dx, 0, 2 * width, height),
            );
          },
          child: widget.child,
        );
      },
    );
  }
}
