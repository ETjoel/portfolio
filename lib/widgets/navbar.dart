
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildWideNavBar(context);
        } else {
          return _buildNarrowNavBar(context);
        }
      },
    );
  }

  Widget _buildWideNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.grey[200]?.withOpacity(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Joel', // Replace with your name
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              _navButton(context, 'Home', '/'),
              const SizedBox(width: 20),
              _navButton(context, 'Admin', '/admin'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowNavBar(BuildContext context) {
    return Container(
      color: Colors.grey[200]?.withOpacity(0.5),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Joel', // Replace with your name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _navButton(context, 'Home', '/'),
              const SizedBox(width: 20),
              _navButton(context, 'Admin', '/admin'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, String text, String route) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed(route),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }
}
