import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';

class HomeTabBarIndicator extends Decoration {
  final Color color;
  final double size;

  HomeTabBarIndicator({
    this.color = primaryColor,
    this.size = 5,
  }) : assert(size > 0);
  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) {
    return _customPainter(this.color, this.size);
  }
}

class _customPainter extends BoxPainter {
  final Color color;
  final double size;

  _customPainter(this.color, this.size);
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final Paint paint = Paint();
    paint.color = this.color;
    final width = configuration.size!.width;
    final height = configuration.size!.height;
    final Offset position =
        Offset(width / 2 + offset.dx, offset.dy + height - 5);
    canvas.drawCircle(position, this.size / 2, paint);
  }
}
