import 'package:advocate/utils/imports.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension MaterialCode on Color {
  MaterialColor toMaterialColor() {
    final List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final r = red, g = green, b = blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(value, swatch);
  }
}

extension ContainerExtension on Container {
  Container radius([int? x]) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(x?.toDouble() ?? 10),
        child: this,
      ),
    );
  }
}
