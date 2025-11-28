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
                                  ? Colors.black
                                  : Colors.grey.shade600,
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
                  color: Colors.grey.shade300,
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
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
