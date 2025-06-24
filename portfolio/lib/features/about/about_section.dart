import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';
import 'package:portfolio/app/theme/app_colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.aboutData});

  final AboutData aboutData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                aboutData.title,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontColor,
                ),
              ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, curve: Curves.easeOut),
              const SizedBox(height: 20),
              Text(
                aboutData.description1,
                style: TextStyle(fontSize: 18, color: AppColors.secondaryFontColor, height: 1.5),
              ).animate().fadeIn(delay: 200.ms, duration: 500.ms).slideX(begin: -0.2, curve: Curves.easeOut),
              const SizedBox(height: 20),
              Text(
                aboutData.description2,
                style: TextStyle(fontSize: 18, color: AppColors.secondaryFontColor, height: 1.5),
              ).animate().fadeIn(delay: 400.ms, duration: 500.ms).slideX(begin: -0.2, curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }
}
