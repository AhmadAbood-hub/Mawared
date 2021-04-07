// model for slide update

import 'package:mawared_app/library/intro_views_flutter-2.4.0/lib/Constants/constants.dart';

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercent;

  SlideUpdate(
    this.direction,
    this.slidePercent,
    this.updateType,
  );
}
