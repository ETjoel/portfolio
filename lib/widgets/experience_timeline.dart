import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../models/experience.dart';

class ExperienceTimeline extends StatefulWidget {
  const ExperienceTimeline({super.key});

  @override
  State<ExperienceTimeline> createState() => _ExperienceTimelineState();
}

class _ExperienceTimelineState extends State<ExperienceTimeline> {
  late List<Experience> _experiences;

  @override
  void initState() {
    super.initState();
    _experiences = [
      Experience(
        company: 'Zulu Tech',
        position: 'Flutter and Flutter Flow Expert',
        period: 'Oct 2024 – Present',
        location: 'Remote',
        responsibilities: [
          'Built cross-platform apps with Flutter & FlutterFlow.',
          'Converted Figma designs into production-ready UIs.',
          'Improved app performance and mentored juniors.',
        ],
        logoAsset: 'assets/images/zulu_tech_logo.png', // Placeholder
      ),
      Experience(
        company: 'Hex Labs',
        position: 'Intern Flutter Developer',
        period: 'Nov 2023 – Feb 2024',
        location: 'Addis Ababa, Ethiopia',
        responsibilities: [
          'Helped build a responsive cross-platform webview app.',
          'Collaborated on seamless integration of a supermarket website.',
        ],
        logoAsset: 'assets/images/hex_labs_logo.png', // Placeholder
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 500, // Adjust as needed
            child: _buildTimeline(isMobile),
          ),
        );
      },
    );
  }

  Widget _buildTimeline(bool isMobile) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _experiences.length,
      itemBuilder: (context, index) {
        final experience = _experiences[index];
        final isFirst = index == 0;
        final isLast = index == _experiences.length - 1;

        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: isMobile ? 0.1 : 0.5,
          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: const LineStyle(
            color: Colors.grey,
            thickness: 2,
          ),
          indicatorStyle: IndicatorStyle(
            width: 40,
            height: 40,
            indicator: _buildIndicator(experience),
            drawGap: true,
          ),
      // Place the card on alternating sides for desktop/tablet.
      // On mobile always place it on the trailing side (endChild) for a single-column look.
      startChild: isMobile
        ? null
        : (index % 2 == 0 ? _buildExperienceCard(experience, isMobile) : null),
      endChild: isMobile
        ? _buildExperienceCard(experience, isMobile)
        : (index % 2 == 1 ? _buildExperienceCard(experience, isMobile) : null),
        );
      },
    );
  }

  Widget _buildIndicator(Experience experience) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.green.shade600,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade600.withOpacity(0.5 * value),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                experience.company.substring(0, 1),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildExperienceCard(Experience experience, bool isMobile) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            experience.position,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            '${experience.company} • ${experience.location}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            experience.period,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          ...experience.responsibilities.map(
            (resp) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(resp)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
