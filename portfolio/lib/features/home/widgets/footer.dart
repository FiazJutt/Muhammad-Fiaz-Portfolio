import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/data/portfolio_data_model.dart';
import 'package:portfolio/app/theme/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.contactData});

  final ContactData contactData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Designed & Built by Muhammad Fiaz',
            style: TextStyle(color: AppColors.secondaryFontColor, fontSize: 14),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
    );
  }
}
