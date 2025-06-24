import 'package:flutter/material.dart';
import 'package:portfolio/app/theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
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
    return Drawer(
      backgroundColor: AppColors.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.cardColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 24, color: AppColors.fontColor),
            ),
          ),
          _createDrawerItem(text: 'Home', onTap: () => onNavigate(homeKey)),
          _createDrawerItem(text: 'About', onTap: () => onNavigate(aboutKey)),
          _createDrawerItem(text: 'Skills', onTap: () => onNavigate(skillsKey)),
          _createDrawerItem(text: 'Experience', onTap: () => onNavigate(experienceKey)),
          _createDrawerItem(text: 'Projects', onTap: () => onNavigate(projectsKey)),
          _createDrawerItem(text: 'Resume', onTap: () => onNavigate(resumeKey)),
          _createDrawerItem(text: 'Contact', onTap: () => onNavigate(contactKey)),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: AppColors.fontColor, fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
