import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';
import 'package:portfolio/app/theme/app_colors.dart';
import 'package:portfolio/features/projects/project_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final ProjectData project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProjectDetailPage(project: widget.project),
          ));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          transform: Matrix4.translationValues(0, _isHovered ? -10 : 0, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildProjectImage(),
                _buildGradientOverlay(),
                _buildCardContent(),
                _buildGithubLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: _isHovered ? 1.05 : 1.0,
      child: Image.asset(
        widget.project.coverImage,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.background,
            child: const Center(
              child: Icon(Icons.image_not_supported, color: AppColors.secondaryFontColor),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.95),
          ],
          stops: const [0.3, 0.6, 1.0],
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.project.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.project.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.85),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          _buildTechStack(),
        ],
      ),
    );
  }

  Widget _buildTechStack() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.project.technologies.map((tech) {
        return Chip(
          label: Text(tech),
          backgroundColor: AppColors.primary.withOpacity(0.15),
          labelStyle: const TextStyle(color: AppColors.primary, fontSize: 11),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          side: BorderSide.none,
        );
      }).toList(),
    );
  }

  Widget _buildGithubLink() {
    if (widget.project.link.isEmpty) {
      return const SizedBox.shrink();
    }
    return Positioned(
      top: 16,
      right: 16,
      child: IconButton(
        icon: const FaIcon(FontAwesomeIcons.github, color: Colors.white),
        onPressed: () => _launchUrl(widget.project.link),
        tooltip: 'View on GitHub',
        hoverColor: AppColors.primary.withOpacity(0.1),
        splashRadius: 24,
      ),
    );
  }
}
