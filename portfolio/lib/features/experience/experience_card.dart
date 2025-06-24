import 'package:flutter/material.dart';
import 'package:portfolio/app/theme/app_colors.dart';

class ExperienceCard extends StatefulWidget {
  final String company;
  final String role;
  final String period;
  final String description;

  const ExperienceCard({
    super.key,
    required this.company,
    required this.role,
    required this.period,
    required this.description,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.role} @ ${widget.company}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.period,
              style: TextStyle(fontSize: 16, color: AppColors.secondaryFontColor),
            ),
            const SizedBox(height: 15),
            Text(
              widget.description,
              style: TextStyle(fontSize: 16, color: AppColors.secondaryFontColor, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
