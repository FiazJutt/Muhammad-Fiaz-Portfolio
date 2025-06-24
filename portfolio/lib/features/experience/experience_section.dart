import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';
import 'package:portfolio/app/theme/app_colors.dart';
import 'package:portfolio/features/experience/experience_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.experience});

  final List<ExperienceData> experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const Text(
                'Where I\'ve Worked',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontColor,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.5, curve: Curves.easeOut),
              const SizedBox(height: 40),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experience.length,
                itemBuilder: (context, index) {
                  final job = experience[index];
                  return _TimelineTile(
                    isFirst: index == 0,
                    isLast: index == experience.length - 1,
                    isLeft: index.isEven,
                    child: ExperienceCard(
                      company: job.company,
                      role: job.role,
                      period: job.period,
                      description: job.description,
                    ),
                  ).animate().fadeIn(delay: (300 * index).ms, duration: 500.ms).slideX(begin: index.isEven ? -0.2 : 0.2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isLeft;
  final Widget child;

  const _TimelineTile({
    required this.isFirst,
    required this.isLast,
    required this.isLeft,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 768;

    return LayoutBuilder(builder: (context, constraints) {
      if (isDesktop) {
        return Row(
          children: [
            if (isLeft) Expanded(child: child) else const Spacer(),
            _buildTimelineConnector(context),
            if (!isLeft) Expanded(child: child) else const Spacer(),
          ],
        );
      } else {
        return Row(
          children: [
            _buildTimelineConnector(context),
            Expanded(child: child),
          ],
        );
      }
    });
  }

  Widget _buildTimelineConnector(BuildContext context) {
    return Container(
      width: 50,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              width: 2,
              color: isFirst ? Colors.transparent : AppColors.primary,
            ),
          ),
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.background, width: 3),
            ),
          ),
          Flexible(
            child: Container(
              width: 2,
              color: isLast ? Colors.transparent : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
