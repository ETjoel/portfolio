import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/views/project_detail_page.dart';

class ThemedProjectCard extends StatefulWidget {
  final Project project;

  const ThemedProjectCard({super.key, required this.project});

  @override
  State<ThemedProjectCard> createState() => _ThemedProjectCardState();
}

class _ThemedProjectCardState extends State<ThemedProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rewardText = '🛠️ ${widget.project.technologies.join(', ')}';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProjectDetailPage(projectId: widget.project.id),
          ),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.rotationZ(_isHovered ? -0.01 : 0),
          transformAlignment: FractionalOffset.center,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              // color: const Color(0xFFF5EEDC), // Parchment color
              border: Border.all(
                  color: Color.fromARGB(255, 17, 59, 20).withOpacity(0.4),
                  width: 3), // Dark brown border
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? Color.fromARGB(255, 17, 59, 20).withOpacity(0.3)
                      : Color.fromARGB(255, 17, 59, 20).withOpacity(0.4),
                  blurRadius: _isHovered ? 15 : 8,
                  spreadRadius: _isHovered ? 2 : 1,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'PROJECT: ${widget.project.title}',
                  style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color.fromARGB(255, 17, 59, 20)
                            .withOpacity(0.4),
                        width: 2),
                  ),
                  child: Image.network(
                    widget.project.images.isNotEmpty
                        ? widget.project.images.first
                        : '',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'TECHNOLOGIES',
                  style: theme.textTheme.headlineMedium?.copyWith(fontSize: 16),
                ),
                Text(
                  rewardText,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Text(
                    widget.project.description,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '--- PERSONAL COLLECTION ---',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(fontFamily: 'Courier'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
