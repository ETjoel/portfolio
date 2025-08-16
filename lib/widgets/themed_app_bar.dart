
import 'package:flutter/material.dart';

class ThemedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const ThemedAppBar({super.key, required this.title, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.5),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      automaticallyImplyLeading: showBackButton,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
