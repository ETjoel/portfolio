import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/project_controller.dart';
import '../widgets/themed_project_card.dart';
import '../widgets/themed_app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  // Track selected nav index
  int selectedIndex = 0;

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
                        : Colors.white,
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
                        : Colors.white,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              setSelectedIndex(2);
              print('$selectedIndex');
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
              'About Me',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: selectedIndex == 2
                        ? Colors.green.shade600
                        : Colors.white,
                  ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                    'assets/images/wallpaperflare.com_wallpaper.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
              ),
            ),
          
          child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    _buildHeroSection(context),
                    _buildSection(context, 'Projects',
                        _buildProjectsGrid(context, projects),
                        key: _projectsKey),
                    _buildAboutSection(context, key: _aboutKey),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        border: Border(
            bottom: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Eyuel Tesfaye', // Replace with your name
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
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content,
      {Key? key}) {
    return Padding(
      key: key,
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

  Widget _buildAboutSection(BuildContext context, {Key? key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(40),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text('About Me',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text(
                """Hi, I’m Eyuel Tesfaye — a Computer Science graduate and Flutter developer from Addis Ababa, Ethiopia. I specialize in building cross-platform, scalable, and user-friendly apps using Flutter and FlutterFlow. Over the past few years, I’ve worked on projects ranging from ride-hailing platforms to cloud storage solutions, delivering responsive UIs, real-time features, and smooth user experiences. I thrive in collaborative environments, enjoy mentoring, and adapt quickly to new technologies. With strong experience in Dart, Python, and modern frameworks, I’m passionate about solving problems through clean, efficient code. When I’m not coding, I’m sharpening my skills on platforms like LeetCode and Codeforces, where I’ve solved 800+ problems. My goal is to continue growing as a developer while building impactful solutions that people love to use.""",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Contact Info:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
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
          ),
        ),
      ),
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
}
