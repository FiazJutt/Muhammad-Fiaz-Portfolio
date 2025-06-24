import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';
import 'package:portfolio/app/theme/app_colors.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.heroData,
    required this.imageUrl,
    required this.onGetInTouchPressed,
  });

  final HeroData heroData;
  final String imageUrl;
  final VoidCallback onGetInTouchPressed;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isButtonHovered = false;
  bool _isImageHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: LayoutBuilder(builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > 950;
        if (isDesktop) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 3, child: _buildTextContent(context)),
              const SizedBox(width: 50),
              Expanded(flex: 2, child: Center(child: _buildImageContent(isDesktop: true))),
            ],
          );
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  _buildImageContent(isDesktop: false),
                  const SizedBox(height: 40),
                  _buildTextContent(context, isDesktop: false),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildTextContent(BuildContext context, {bool isDesktop = true}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final titleSize = isDesktop ? (screenHeight * 0.08).clamp(40.0, 70.0) : 36.0;
    final subtitleSize = isDesktop ? (screenHeight * 0.06).clamp(30.0, 60.0) : 28.0;
    final descriptionSize = isDesktop ? (screenHeight * 0.025).clamp(16.0, 22.0) : 16.0;
    final buttonPadding = isDesktop ? (screenHeight * 0.02).clamp(15.0, 25.0) : 20.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          widget.heroData.greeting,
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: descriptionSize, 
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeInOut),
        const SizedBox(height: 8),
        Text(
          widget.heroData.name,
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: AppColors.fontColor,
          ),
        ).animate().fadeIn(delay: 300.ms, duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeInOut),
        SizedBox(height: screenHeight * 0.02),
        Text(
          widget.heroData.subtitle,
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: subtitleSize,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryFontColor,
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeInOut),
        SizedBox(height: screenHeight * 0.04),
        Text(
          widget.heroData.description,
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: descriptionSize,
            color: AppColors.secondaryFontColor,
          ),
        ).animate().fadeIn(delay: 500.ms, duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeInOut),
        SizedBox(height: screenHeight * 0.05),
        MouseRegion(
          onEnter: (_) => setState(() => _isButtonHovered = true),
          onExit: (_) => setState(() => _isButtonHovered = false),
          cursor: SystemMouseCursors.click,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: _isButtonHovered ? 1.05 : 1.0),
            duration: const Duration(milliseconds: 200),
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: ElevatedButton(
              onPressed: widget.onGetInTouchPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: buttonPadding),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                shadowColor: AppColors.primary.withOpacity(0.5),
                elevation: _isButtonHovered ? 10 : 5,
              ),
              child: const Text(
                'Get In Touch',
                style: TextStyle(color: AppColors.background, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ).animate().fadeIn(delay: 600.ms, duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeInOut),
      ],
    );
  }

  Widget _buildImageContent({required bool isDesktop}) {
    final imageSize = isDesktop ? 300.0 : 200.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _isImageHovered = true),
      onExit: (_) => setState(() => _isImageHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: imageSize,
        height: imageSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isImageHovered ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: _isImageHovered
              ? [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 20, spreadRadius: 2)]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            widget.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.2, curve: Curves.easeOut);
  }
}
