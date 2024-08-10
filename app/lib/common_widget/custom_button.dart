import 'package:flutter/material.dart';
Widget CustomButton(
  String title,
  IconData icon,
  VoidCallback onTap,
  double screenWidth,
  BuildContext context,
) {
  final ThemeData theme = Theme.of(context);
  final Color primaryColor = theme.colorScheme.primary;
  final Color secondaryColor = theme.colorScheme.secondary;

  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        width: screenWidth * 0.90 - 30,
        height: 50,
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              primaryColor,
              primaryColor.withOpacity(0.8), // Adjust opacity for gradient
              primaryColor.withOpacity(0.6), // Adjust opacity for gradient
            ],
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 50),
            Icon(icon, color: secondaryColor),
            const SizedBox(width: 30),
            Expanded(
              child: Text(
                title,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
