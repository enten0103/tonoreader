import 'package:flutter/material.dart';

class ExpanBox extends StatefulWidget {
  const ExpanBox({
    super.key,
    required this.isOpen,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  final bool isOpen;
  final Widget child;
  final Duration duration;

  @override
  State<ExpanBox> createState() => _ExpanBoxState();
}

class _ExpanBoxState extends State<ExpanBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(() => setState(() {}));
    _updateAnimation();
  }

  @override
  void didUpdateWidget(ExpanBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    widget.isOpen ? _controller.forward() : _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.duration,
      alignment: Alignment.topLeft,
      curve: Curves.easeInOut,
      child: _controller.value > 0
          ? ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                heightFactor: _controller.value,
                child: widget.child,
              ),
            )
          : null,
    );
  }
}
