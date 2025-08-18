import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/views/project_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
          child: Card(
            shadowColor: Theme.of(context).colorScheme.secondary,
            elevation: 0,
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.secondary, width: 1),
                borderRadius: BorderRadius.circular(12),
                color: _isHovered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'PROJECT: ${widget.project.title}',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontSize: 20),
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
                      child: SizedBox(
                        // width: 250, // Set a fixed width for the image
                        height: 150, // Set a fixed height for the image
                        child: Image.network(
                          widget.project.images.isNotEmpty
                              ? widget.project.images.first
                              : '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'TECHNOLOGIES',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontSize: 16),
                    ),
                    Text(
                      rewardText,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    if (widget.project.githubLink != null &&
                        widget.project.githubLink!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                        child: InkWell(
                          onTap: () async {
                            final url = Uri.parse(widget.project.githubLink!);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Could not launch ${widget.project.githubLink}')),
                              );
                            }
                          },
                          child: Container(
                             padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: theme.colorScheme.primary, width: 1),
                      ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.open_in_new,
                                    size: 16, color: theme.colorScheme.primary),
                                const SizedBox(width: 6),
                                Text(
                                  'Visit GitHub Repo',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      widget.project.description,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: theme.colorScheme.primary, width: 1),
                      ),
                      child: Text(
                        'View More',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
