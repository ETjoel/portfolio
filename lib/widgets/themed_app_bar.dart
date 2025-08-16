import 'package:flutter/material.dart';

class ThemedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const ThemedAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.5),
      // title: Text(
      //   title,
      //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      //     color: Theme.of(context).colorScheme.onPrimary,
      //   ),
      // ),
      automaticallyImplyLeading: showBackButton,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
}
