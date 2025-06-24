import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';
import 'package:portfolio/app/theme/app_colors.dart';
import 'package:portfolio/features/projects/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.projects});

  final List<ProjectData> projects;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Some Things I\'ve Built',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppColors.fontColor,
            ),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              if (constraints.maxWidth > 1100) {
                crossAxisCount = 3;
              } else if (constraints.maxWidth > 768) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.3,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(project: projects[index])
                      .animate()
                      .fadeIn(delay: (200 * (index % crossAxisCount)).ms, duration: 500.ms)
                      .slideY(begin: 0.3, curve: Curves.easeInOut);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
