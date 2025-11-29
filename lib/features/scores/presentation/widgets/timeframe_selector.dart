import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/timeframe.dart';

class TimeframeSelector extends StatelessWidget {
  final Timeframe selected;
  final ValueChanged<Timeframe> onChanged;

  const TimeframeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final frames = Timeframe.values;
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.light;
    final isDark = brightness == Brightness.dark;
    final selectedColor = isDark ? Colors.white : Colors.black;
    final unselectedColor =
        isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final dividerColor = isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / frames.length;
        final indicatorWidth = itemWidth;
        final selectedIndex = frames.indexOf(selected);

        return SizedBox(
          height: 45,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Row(
                children: [
                  for (final frame in frames)
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onChanged(frame),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            frame.label.toUpperCase(),
                            style: TextStyle(
                              fontWeight: frame == selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: frame == selected
                                  ? selectedColor
                                  : unselectedColor,
                              fontSize: 15,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: dividerColor,
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOut,
                bottom: 0,
                left: itemWidth * selectedIndex,
                width: indicatorWidth,
                child: Container(
                  height: 3,
                  color: selectedColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
