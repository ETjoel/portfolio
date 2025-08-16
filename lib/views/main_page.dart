import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/project_controller.dart';
import '../widgets/themed_project_card.dart';
import '../widgets/themed_app_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<ProjectController>(context).projects;

    return Scaffold(
      appBar: const ThemedAppBar(title: 'Pirate\'s Portfolio'),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildSection(context, 'My Latest Voyages (Projects)', _buildProjectsGrid(context, projects)),
            _buildAboutSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
      ),
      child: Column(
        children: [
          Text(
            'Joel, The Code Pirate', // Replace with your name
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Sailing the vast seas of technology, in search of elegant solutions and hidden treasures.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          content,
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, List<dynamic> projects) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200
            ? 3
            : constraints.maxWidth > 800
                ? 2
                : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.8,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ThemedProjectCard(project: projects[index]);
          },
        );
      },
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text('The Captain\'s Log', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text(
                'Here, you can write a more detailed account of your journey as a developer. Talk about your passions, your philosophy on coding, and what you\'re currently learning. This is a great place to show your personality while maintaining a professional tone.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
