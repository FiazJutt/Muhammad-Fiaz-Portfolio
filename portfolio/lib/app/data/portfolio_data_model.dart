class PortfolioData {
  final String name;
  final HeroData hero;
  final AboutData about;
  final List<String> skills;
  final List<ExperienceData> experience;
  final List<ProjectData> projects;
  final ContactData contact;
  final String resumeUrl;

  PortfolioData({
    required this.name,
    required this.hero,
    required this.about,
    required this.skills,
    required this.experience,
    required this.projects,
    required this.contact,
    required this.resumeUrl,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      name: json['name'] ?? '',
      hero: HeroData.fromJson(json['hero'] ?? {}),
      about: AboutData.fromJson(json['about'] ?? {}),
      skills: json['skills'] != null
          ? List<String>.from(json['skills'])
          : [],
      experience: json['experience'] != null
          ? List<ExperienceData>.from(json['experience'].map((x) => ExperienceData.fromJson(x)))
          : [],
      projects: json['projects'] != null
          ? List<ProjectData>.from(json['projects'].map((x) => ProjectData.fromJson(x)))
          : [],
      contact: ContactData.fromJson(json['contact'] ?? {}),
      resumeUrl: json['resume_url'] ?? '',
    );
  }
}

class HeroData {
  final String greeting;
  final String name;
  final String subtitle;
  final String description;

  HeroData({
    required this.greeting,
    required this.name,
    required this.subtitle,
    required this.description,
  });

  factory HeroData.fromJson(Map<String, dynamic> json) {
    return HeroData(
      greeting: json['greeting'] ?? '',
      name: json['name'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class AboutData {
  final String title;
  final String description1;
  final String description2;
  final String imageUrl;

  AboutData({required this.title, required this.description1, required this.description2, required this.imageUrl});

  factory AboutData.fromJson(Map<String, dynamic> json) {
    return AboutData(
      title: json['title'] ?? '',
      description1: json['description1'] ?? '',
      description2: json['description2'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}

class ExperienceData {
  final String role;
  final String company;
  final String period;
  final String description;

  ExperienceData(
      {required this.role,
      required this.company,
      required this.period,
      required this.description});

  factory ExperienceData.fromJson(Map<String, dynamic> json) {
    return ExperienceData(
      role: json['role'] ?? '',
      company: json['company'] ?? '',
      period: json['period'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class ProjectData {
  final String title;
  final String subtitle;
  final String description;
  final List<String> technologies;
  final String link;
  final String coverImage;
  final List<String> detailImages;

  ProjectData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.technologies,
    required this.link,
    required this.coverImage,
    required this.detailImages,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      technologies: json['technologies'] != null
          ? List<String>.from(json['technologies'])
          : [],
      link: json['link'] ?? '',
      coverImage: json['coverImage'] ?? '',
      detailImages: json['detailImages'] != null
          ? List<String>.from(json['detailImages'])
          : [],
    );
  }
}

class ContactData {
  final String title;
  final String description;
  final String email;
  final String linkedin;
  final String github;

  ContactData({
    required this.title,
    required this.description,
    required this.email,
    required this.linkedin,
    required this.github,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      email: json['email'] ?? '',
      linkedin: json['linkedin'] ?? '',
      github: json['github'] ?? '',
    );
  }
}
