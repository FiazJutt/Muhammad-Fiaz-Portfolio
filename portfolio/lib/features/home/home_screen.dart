import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/theme/app_colors.dart';
import 'package:portfolio/features/about/about_section.dart';
import 'package:portfolio/features/contact/contact_section.dart';
import 'package:portfolio/features/experience/experience_section.dart';
import 'package:portfolio/features/home/widgets/app_drawer.dart';
import 'package:portfolio/features/home/widgets/footer.dart';
import 'package:portfolio/features/home/widgets/hero_section.dart';
import 'package:portfolio/features/home/widgets/nav_bar.dart';
import 'package:portfolio/features/projects/projects_section.dart';
import 'package:portfolio/features/resume/resume_section.dart';
import 'package:portfolio/features/skills/skills_section.dart';
import 'package:portfolio/app/data/data_service.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final projectsKey = GlobalKey();
  final resumeKey = GlobalKey();
  final contactKey = GlobalKey();

  late Future<PortfolioData> _portfolioData;
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _portfolioData = DataService().loadPortfolioData();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 400) {
        if (!_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = true;
          });
        }
      } else {
        if (_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        onNavigate: _scrollToSection,
        homeKey: homeKey,
        aboutKey: aboutKey,
        skillsKey: skillsKey,
        experienceKey: experienceKey,
        projectsKey: projectsKey,
        resumeKey: resumeKey,
        contactKey: contactKey,
      ),
      endDrawer: AppDrawer(
        onNavigate: _scrollToSection,
        homeKey: homeKey,
        aboutKey: aboutKey,
        skillsKey: skillsKey,
        experienceKey: experienceKey,
        projectsKey: projectsKey,
        resumeKey: resumeKey,
        contactKey: contactKey,
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton.small(
              onPressed: _scrollToTop,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.arrow_upward, color: Colors.white, size: 20),
            )
          : null,
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            baseColor: AppColors.primary,
            spawnOpacity: 0.0,
            opacityChangeRate: 0.25,
            minOpacity: 0.1,
            maxOpacity: 0.3,
            particleCount: 70,
            spawnMaxRadius: 15.0,
            spawnMinRadius: 10.0,
            spawnMaxSpeed: 100.0,
            spawnMinSpeed: 30.0,
          ),
        ),
        vsync: this,
        child: FutureBuilder<PortfolioData>(
          future: _portfolioData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    HeroSection(
                      key: homeKey,
                      heroData: data.hero,
                      imageUrl: data.about.imageUrl,
                      onGetInTouchPressed: () => _scrollToSection(contactKey),
                    ),
                    AboutSection(key: aboutKey, aboutData: data.about),
                    SkillsSection(key: skillsKey, skills: data.skills),
                    ExperienceSection(key: experienceKey, experience: data.experience),
                    ProjectsSection(key: projectsKey, projects: data.projects),
                    ResumeSection(key: resumeKey, resumeUrl: data.resumeUrl),
                    ContactSection(key: contactKey, contactData: data.contact),
                    Footer(contactData: data.contact),
                  ].animate(interval: 200.ms).fade(duration: 800.ms).slideY(begin: 0.5, end: 0),
                ),
              );
            }
            return const Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }
}
