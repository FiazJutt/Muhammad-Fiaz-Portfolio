import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/theme/app_colors.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'My Skills',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontColor,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.5, curve: Curves.easeOut),
              const SizedBox(height: 40),
              Wrap(
                spacing: 15.0,
                runSpacing: 15.0,
                alignment: WrapAlignment.center,
                children: skills
                    .map((skill) => _SkillChip(skill: skill))
                    .toList(),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 500.ms)
                  .slideY(begin: 0.5, curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({required this.skill});

  final String skill;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primary.withOpacity(0.1) : AppColors.cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withOpacity(0.5)),
        ),
        child: Chip(
          label: Text(widget.skill),
          backgroundColor: Colors.transparent,
          labelStyle: const TextStyle(color: AppColors.primary, fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
