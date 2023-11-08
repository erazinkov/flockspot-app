import 'package:flutter/material.dart';

class ChipNumber extends StatelessWidget {
  const ChipNumber({
    super.key,
    required this.number,
    this.styles = const ChipNumberStyles(),
  });

  final int number;
  final ChipNumberStyles styles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: styles.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: styles.color,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${styles.prefixText}$number',
            style: const TextStyle(
              height: 1.0,
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (styles.isSmallChipShown) ...[
            const SizedBox(
              width: 4,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Text(
                'flocks'.toUpperCase(),
                style: const TextStyle(
                  height: 1.0,
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class ChipNumberStyles {
  final String prefixText;
  final Color color;
  final EdgeInsetsGeometry padding;
  final bool isSmallChipShown;

  const ChipNumberStyles({
    this.prefixText = '',
    this.color = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.isSmallChipShown = false,
  });

  factory ChipNumberStyles.flock() => const ChipNumberStyles(
        prefixText: '',
        color: Color.fromRGBO(255, 151, 54, 1),
        padding: EdgeInsets.only(
          left: 12,
          top: 4,
          right: 4,
          bottom: 4,
        ),
        isSmallChipShown: true,
      );

  factory ChipNumberStyles.user() => const ChipNumberStyles(
        prefixText: '+',
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        isSmallChipShown: false,
      );
}
