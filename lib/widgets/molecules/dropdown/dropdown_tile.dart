import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class DropdownTile extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const DropdownTile({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  State<DropdownTile> createState() => _DropdownTileState();
}

class _DropdownTileState extends State<DropdownTile> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // HEADER (title + arrow)
        GestureDetector(
          onTap: _toggleExpand,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: ThemeApp.color.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: ThemeApp.font.medium.copyWith(fontSize: 14),
                  ),
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0, // rotate arrow
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),

        // BODY (animasi expand)
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Column(
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
