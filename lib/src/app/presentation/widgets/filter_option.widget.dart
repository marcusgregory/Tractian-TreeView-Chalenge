import 'package:flutter/material.dart';

class FilterOptionWidget extends StatelessWidget {
  const FilterOptionWidget({
    super.key,
    required this.onTapCallback,
    required this.isSelected,
    required this.icon,
    required this.textLabel,
  });

  final void Function(bool) onTapCallback;
  final bool isSelected;
  final IconData icon;
  final String textLabel;

  @override
  Widget build(BuildContext context) {
    BorderRadius roundedCorners = BorderRadius.circular(3.0);
    Color? borderColor = const Color(0xFFD8DFE6);
    Color? iconAndTextColor = const Color(0xFF77818C);
    Color? backgroundColor;

    if (isSelected) {
      borderColor = Theme.of(context).primaryColor;
      backgroundColor = Theme.of(context).primaryColor;
      iconAndTextColor = Theme.of(context).colorScheme.onPrimary;
    }

    return InkWell(
      onTap: () => onTapCallback(!isSelected),
      borderRadius: roundedCorners,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: roundedCorners,
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconAndTextColor,
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Text(
                textLabel,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: iconAndTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
