import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';
import 'package:portfolio/app/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.contactData});

  final ContactData contactData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Text(
                contactData.title,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontColor,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.5, curve: Curves.easeOut),
              const SizedBox(height: 20),
              Text(
                contactData.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.secondaryFontColor, height: 1.5),
              ).animate().fadeIn(delay: 200.ms, duration: 500.ms).slideY(begin: -0.5, curve: Curves.easeOut),
              const SizedBox(height: 40),
              _SocialLinks(contactData: contactData)
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

class _SocialLinks extends StatelessWidget {
  final ContactData contactData;

  const _SocialLinks({required this.contactData});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(
          icon: FontAwesomeIcons.github,
          tooltip: 'GitHub',
          onPressed: () => _launchUrl(contactData.github),
        ),
        const SizedBox(width: 25),
        _SocialIcon(
          icon: FontAwesomeIcons.linkedin,
          tooltip: 'LinkedIn',
          onPressed: () => _launchUrl(contactData.linkedin),
        ),
        const SizedBox(width: 25),
        _SocialIcon(
          icon: Icons.email_outlined,
          tooltip: 'Email',
          onPressed: () => _launchUrl('mailto:${contactData.email}'),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _SocialIcon({required this.icon, required this.tooltip, required this.onPressed});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedScale(
            scale: _isHovered ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              widget.icon,
              color: _isHovered ? AppColors.primary : AppColors.fontColor,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
