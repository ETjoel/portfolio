import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../controllers/project_controller.dart';
import '../widgets/themed_project_card.dart';
import '../widgets/themed_app_bar.dart';
import '../widgets/experience_timeline.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  // Track selected nav index
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch projects when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProjectController>(context, listen: false).fetchProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<ProjectController>(context).projects;

    void setSelectedIndex(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: ThemedAppBar(
        title: 'Eyuel\'s Portfolio',
        actions: [
          TextButton(
            onPressed: () {
              setSelectedIndex(0);
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'Home',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: selectedIndex == 0
                        ? Colors.green.shade600
                        : Colors.black26,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              setSelectedIndex(1);
              Scrollable.ensureVisible(
                _projectsKey.currentContext!,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'Projects',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: selectedIndex == 1
                        ? Colors.green.shade600
                        : Colors.black,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              setSelectedIndex(2);
              Scrollable.ensureVisible(
                _aboutKey.currentContext!,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            onLongPress: () {
              context.goNamed(RouteConstants.login);
            },
            child: Text(
              'About',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: selectedIndex == 2
                        ? Colors.green.shade600
                        : Colors.black,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              setSelectedIndex(3);
              Scrollable.ensureVisible(
                _experienceKey.currentContext!,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'Experience',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: selectedIndex == 3
                        ? Colors.green.shade600
                        : Colors.black,
                  ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroSection(context),
                  _buildSection(context, 'About Me',
                      _buildAboutSection(context, key: _aboutKey)),
                  _buildSection(context, 'Projects',
                      _buildProjectsGrid(context, projects),
                      key: _projectsKey),
                  _buildSection(context, 'Professional Experience',
                      const ExperienceTimeline(),
                      key: _experienceKey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.99),
        border: Border(
            bottom: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Name and tagline
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eyuel Tesfaye',
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Sailing the vast seas of technology, in search of elegant solutions and hidden treasures.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.green.shade600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Right: Contact icons
          Container(
            margin: const EdgeInsets.only(left: 24, right: 8, top: 8),
            child: Column(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
              children: [
                // GitHub
                _ContactIconButton(
                  assetPath: 'assets/images/github.png',
                  tooltip: 'GitHub',
                  onTap: () async {
                    final url = Uri.parse('https://github.com/ETjoel');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                ),
                // const SizedBox(width: 12),
                // LinkedIn (renamed to linkedin.png)
                _ContactIconButton(
                  assetPath: 'assets/images/linkedin.png',
                  tooltip: 'LinkedIn',
                  onTap: () async {
                    final url =
                        Uri.parse('http://linkedin.com/in/ejoel-tesfaye');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                ),
                // const SizedBox(width: 12),
                // Mail
                _ContactIconButton(
                  assetPath: 'assets/images/communication.png',
                  tooltip: 'Copy Email',
                  onTap: () async {
                    await Clipboard.setData(
                        const ClipboardData(text: 'ejoeltesfaye@gmail.com'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Email copied: ejoeltesfaye@gmail.com')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content,
      {Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20.0),
      child: Card(
        elevation: 5,
        shadowColor: Colors.green.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(height: 24),
              content,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, List<dynamic> projects) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Fix: wrap horizontal ListView in a SizedBox with fixed height
        return SizedBox(
          height: 400, // Adjust as needed for your card height
          child: ListView.builder(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ThemedProjectCard(project: projects[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildAboutSection(BuildContext context, {Key? key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: double.infinity),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsive: stack vertically on small screens
              bool isNarrow = constraints.maxWidth < 600;
              return isNarrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _aboutMeColumn(context),
                        // const SizedBox(height: 32),
                        // Divider(
                        //   color: Theme.of(context).colorScheme.primary,
                        //   thickness: 1.5,
                        // ),
                      //   const SizedBox(height: 32),
                      //   _contactInfoColumn(context),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _aboutMeColumn(context)),
                        // Container(
                        //   margin: const EdgeInsets.symmetric(horizontal: 32),
                        //   height: 350,
                        //   child: VerticalDivider(
                        //     color: Theme.of(context).colorScheme.primary,
                        //     thickness: 1.5,
                        //   ),
                        // ),
                        // Expanded(child: _contactInfoColumn(context)),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _aboutMeColumn(BuildContext context) {
    return Text(
      """Hey, I’m Eyuel Tesfaye, a Flutter wizard 🧙‍♂️ from Addis Ababa, Ethiopia! I’m a Computer Science grad who crafts slick, cross-platform apps with Flutter and FlutterFlow. From ride-hailing to cloud storage, I build snappy UIs and real-time features that users adore 😎. I love team vibes, mentoring, and picking up new tech faster than you can say "bug fix" 🐞. I sling clean code in Dart and Python, and when I’m not coding, I’m crushing it on LeetCode and Codeforces (800+ problems down! 💪). My mission? Keep growing and whipping up apps that make people go "Wow!" 🚀""",
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.left,
    );
  }

  Widget _contactInfoColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Info:',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildContactInfo(
          context,
          'GitHub: ETjoel',
          'https://github.com/ETjoel',
        ),
        _buildContactInfo(
          context,
          'Email: ejoeltesfaye@gmail.com',
          'mailto:ejoeltesfaye@gmail.com',
        ),
        _buildContactInfo(
          context,
          'LinkedIn: ejoel-tesfaye',
          'http://linkedin.com/in/ejoel-tesfaye',
        ),
        _buildContactInfo(
          context,
          'Phone: +251717156312',
          'tel:+251717156312',
        ),
        _buildContactInfo(
          context,
          'Phone: +251939896312',
          'tel:+251939896312',
        ),
      ],
    );
  }

Widget _buildContactInfo(BuildContext context, String text, String url) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $url')),
          );
        }
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

// Contact icon button widget
class _ContactIconButton extends StatelessWidget {
  final String assetPath;
  final String tooltip;
  final VoidCallback onTap;

  const _ContactIconButton({
    required this.assetPath,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Image.asset(
            assetPath,
            width: 36,
            height: 36,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
