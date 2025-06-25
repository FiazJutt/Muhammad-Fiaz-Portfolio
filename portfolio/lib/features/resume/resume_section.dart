import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:portfolio/app/theme/app_colors.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key, required this.resumeUrl});

  final String resumeUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              const Text(
                'My Resume',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontColor,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.5, curve: Curves.easeOut),
              const SizedBox(height: 20),
              Text(
                'Grab a copy of my resume to see my full professional story.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.secondaryFontColor, height: 1.5),
              ).animate().fadeIn(delay: 200.ms, duration: 500.ms).slideY(begin: -0.5, curve: Curves.easeOut),
              const SizedBox(height: 40),
              _DownloadButton(resumeUrl: resumeUrl)
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 500.ms)
                  .slideY(begin: -0.5, curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }
}

class _DownloadButton extends StatefulWidget {
  final String resumeUrl;

  const _DownloadButton({required this.resumeUrl});

  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton> {
  bool _isHovered = false;

  void _launchResume() {
    // This is the standard web-only approach to trigger a file download.
    // We use dart:html to create an anchor element and programmatically click it.
    // We construct the full URL to ensure the path is absolute and unambiguous.
    final baseUrl = html.window.location.origin;
    final url = '$baseUrl/assets/documents/Muhammad_Fiaz_Resume.pdf';
    html.AnchorElement(href: url)
      ..setAttribute('download', 'Muhammad_Fiaz_Resume.pdf')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ElevatedButton.icon(
        onPressed: _launchResume,
        icon: const Icon(Icons.download_rounded, color: AppColors.background),
        label: const Text(
          'Download Resume',
          style: TextStyle(color: AppColors.background, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: AppColors.primary.withOpacity(0.5),
          elevation: _isHovered ? 10 : 5,
        ),
      ),
    );
  }
}
