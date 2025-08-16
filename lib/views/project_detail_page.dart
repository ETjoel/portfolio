import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/project_controller.dart';
import '../widgets/themed_app_bar.dart';

class ProjectDetailPage extends StatelessWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    final project = Provider.of<ProjectController>(context, listen: false).getProjectById(projectId);

    if (project == null) {
      return Scaffold(
        appBar: const ThemedAppBar(title: 'Lost at Sea'),
        body: Center(
          child: Text('This treasure seems to be lost at sea...', style: Theme.of(context).textTheme.headlineMedium),
        ),
      );
    }

    return Scaffold(
      appBar: ThemedAppBar(title: project.title, showBackButton: true),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF9F3), // A slightly different parchment color
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
                    border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2), width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.title, style: Theme.of(context).textTheme.displayLarge),
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          project.imageUrl,
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('The Captain\'s Account', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 16),
                      Text(project.description, style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 24),
                      Text('Ancient Runes Used', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: project.technologies
                            .map((tech) => Chip(
                                  label: Text(tech),
                                  backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                                ))
                            .toList(),
                      ),
                      if (project.githubLink != null && project.githubLink!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Center(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.explore),
                              label: const Text('View the Secret Chart'),
                              onPressed: () async {
                                final Uri url = Uri.parse(project.githubLink!);
                                if (!await launchUrl(url)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Could not launch chart: $url')),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}