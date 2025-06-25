import 'package:flutter/material.dart';
import 'package:portfolio/app/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key, required this.resumeUrl});

  final String resumeUrl;

  void _launchResume(String url) async {
    // For web, launching the relative asset path is sufficient.
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Center(
        child: Column(
          children: [
            const Text(
              'My Resume',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColors.fontColor,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _launchResume(resumeUrl),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
              ),
              child: const Text(
                'Download Resume',
                style: TextStyle(color: AppColors.background, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
