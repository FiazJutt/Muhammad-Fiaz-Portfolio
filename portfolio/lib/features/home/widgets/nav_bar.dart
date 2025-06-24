import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/theme/app_colors.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
    required this.onNavigate,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.resumeKey,
    required this.contactKey,
  });

  final void Function(GlobalKey) onNavigate;
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey resumeKey;
  final GlobalKey contactKey;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < 768;
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.background,
          title: Text('Muhammad Fiaz',
              style: TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold))
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms),
          actions: isNarrow
              ? [_buildNarrowNavBar(context)]
              : _buildWideNavBar(),
        ).animate().fadeIn(duration: 300.ms);
      },
    );
  }

  Widget _buildNarrowNavBar(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: AppColors.primary),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    ).animate().fadeIn(duration: 400.ms, delay: 200.ms);
  }

  List<Widget> _buildWideNavBar() {
    final navButtons = <Widget>[
      _NavButton(title: 'About', onNavigate: () => onNavigate(aboutKey)),
      _NavButton(title: 'Skills', onNavigate: () => onNavigate(skillsKey)),
      _NavButton(title: 'Experience', onNavigate: () => onNavigate(experienceKey)),
      _NavButton(title: 'Projects', onNavigate: () => onNavigate(projectsKey)),
      _NavButton(title: 'Contact', onNavigate: () => onNavigate(contactKey)),
      const SizedBox(width: 16),
      ElevatedButton(
        onPressed: () => onNavigate(resumeKey),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: const Text(
          'Resume',
          style: TextStyle(color: AppColors.background, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(width: 16),
    ];

    return [
      Row(
        children: navButtons,
      ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavButton extends StatefulWidget {
  const _NavButton({required this.title, required this.onNavigate});

  final String title;
  final VoidCallback onNavigate;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onNavigate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: _isHovered ? AppColors.primary : AppColors.fontColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 20 : 0,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
