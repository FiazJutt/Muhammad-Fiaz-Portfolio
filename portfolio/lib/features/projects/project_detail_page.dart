import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';
import 'package:portfolio/app/theme/app_colors.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectData project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        backgroundColor: AppColors.cardColor,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProjectHeader(title: project.title, subtitle: project.subtitle),
                  const SizedBox(height: 24),
                  if (project.detailImages.isNotEmpty)
                    _ImageGallery(images: project.detailImages),
                  const SizedBox(height: 32),
                  _SectionContent(
                    title: 'About this project',
                    content: Text(
                      project.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.secondaryFontColor,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _SectionContent(
                    title: 'Technologies Used',
                    content: _TechnologyChips(technologies: project.technologies),
                  ),
                ],
              ).animate().fadeIn(duration: 500.ms),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ProjectHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppColors.fontColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.secondaryFontColor,
          ),
        ),
      ],
    ).animate().slideX(begin: -0.1, duration: 400.ms, curve: Curves.easeOut);
  }
}

class _ImageGallery extends StatelessWidget {
  final List<String> images;

  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 400,
                      color: AppColors.background,
                      child: const Center(
                        child: Icon(Icons.image_not_supported, color: Colors.white24),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).scaleXY(begin: 0.95, curve: Curves.easeOut);
  }
}

class _SectionContent extends StatelessWidget {
  final String title;
  final Widget content;

  const _SectionContent({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.fontColor,
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideY(begin: 0.1, curve: Curves.easeOut);
  }
}

class _TechnologyChips extends StatelessWidget {
  final List<String> technologies;

  const _TechnologyChips({required this.technologies});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: technologies
          .map((tech) => Chip(
                label: Text(tech),
                backgroundColor: AppColors.primary.withOpacity(0.1),
                labelStyle: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ))
          .toList(),
    );
  }
}
