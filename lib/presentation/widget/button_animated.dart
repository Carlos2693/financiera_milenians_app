import 'package:flutter/material.dart';

import 'package:financiera_milenians_app/config/theme/app_theme.dart';

class ButtonAnimated extends StatefulWidget {
  final String amount;
  final Color? baseColor;
  final VoidCallback callback;

  const ButtonAnimated(
      {super.key, required this.amount, required this.callback, this.baseColor});

  @override
  State<ButtonAnimated> createState() => _ButtonAnimatedState();
}

class _ButtonAnimatedState extends State<ButtonAnimated> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.callback,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (details) => setState(() {
        _isPressed = false;
      }),
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        width: double.infinity,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: _isPressed ? AppTheme.buttonPressedColor : widget.baseColor ?? AppTheme.buttonColor,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: AppTheme.buttonPressedColor.withAlpha(250),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.amount,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
