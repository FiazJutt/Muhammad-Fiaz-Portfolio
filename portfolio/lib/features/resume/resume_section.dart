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
                  )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: -0.5, curve: Curves.easeOut),
              const SizedBox(height: 20),
              Text(
                    'Grab a copy of my resume to see my full professional story.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.secondaryFontColor,
                      height: 1.5,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 500.ms)
                  .slideY(begin: -0.5, curve: Curves.easeOut),
              const SizedBox(height: 40),
              // Two buttons - one for direct download, one for viewing
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _DownloadButton(resumeUrl: resumeUrl)
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 500.ms)
                      .slideY(begin: -0.5, curve: Curves.easeOut),
                  const SizedBox(width: 20),
                  _ViewButton(resumeUrl: resumeUrl)
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 500.ms)
                      .slideY(begin: -0.5, curve: Curves.easeOut),
                ],
              ),
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
  bool _isLoading = false;

  Future<void> _downloadResume() async {
    setState(() => _isLoading = true);

    try {
      // Multiple approaches for better compatibility
      await _tryDirectDownload();
    } catch (e) {
      // Fallback: Try opening in new tab if direct download fails
      await _tryViewInNewTab();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _tryDirectDownload() async {
    // Method 1: Using assets path (for Flutter web assets)
    const assetPath = 'assets/documents/Muhammad_Fiaz_Resume.pdf';

    try {
      // Create anchor element for download
      final anchor = html.AnchorElement()
        ..href = assetPath
        ..download = 'Muhammad_Fiaz_Resume.pdf'
        ..style.display = 'none';

      html.document.body?.append(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);

      return; // Success
    } catch (e) {
      // Method 2: Try with full URL construction
      final baseUrl = html.window.location.origin;
      final fullUrl = '$baseUrl/$assetPath';

      final anchor = html.AnchorElement()
        ..href = fullUrl
        ..download = 'Muhammad_Fiaz_Resume.pdf'
        ..target = '_blank'
        ..style.display = 'none';

      html.document.body?.append(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);
    }
  }

  Future<void> _tryViewInNewTab() async {
    const assetPath = 'assets/documents/Muhammad_Fiaz_Resume.pdf';
    final baseUrl = html.window.location.origin;
    final fullUrl = '$baseUrl/$assetPath';

    // Open in new tab/window
    html.window.open(fullUrl, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _downloadResume,
        icon: _isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.background,
                  ),
                ),
              )
            : const Icon(Icons.download_rounded, color: AppColors.background),
        label: Text(
          _isLoading ? 'Downloading...' : 'Download Resume',
          style: const TextStyle(color: AppColors.background, fontSize: 18),
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

class _ViewButton extends StatefulWidget {
  final String resumeUrl;

  const _ViewButton({required this.resumeUrl});

  @override
  State<_ViewButton> createState() => _ViewButtonState();
}

class _ViewButtonState extends State<_ViewButton> {
  bool _isHovered = false;

  void _viewResume() {
    const assetPath = 'assets/documents/Muhammad_Fiaz_Resume.pdf';
    final baseUrl = html.window.location.origin;
    final fullUrl = '$baseUrl/$assetPath';

    // Open PDF in new tab for viewing
    html.window.open(fullUrl, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: OutlinedButton.icon(
        onPressed: _viewResume,
        icon: const Icon(Icons.visibility_rounded, color: AppColors.primary),
        label: const Text(
          'View Resume',
          style: TextStyle(color: AppColors.primary, fontSize: 18),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: AppColors.primary.withOpacity(0.3),
          elevation: _isHovered ? 5 : 0,
        ),
      ),
    );
  }
}
