class OnboardingSlide {
  const OnboardingSlide({
    required this.brand,
    required this.product,
    required this.series,
    required this.image,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String brand;
  final String product;
  final String series;
  final String image;
  final String eyebrow;
  final String title;
  final String description;

  static const all = [
    OnboardingSlide(
      brand: 'AE SIGNATURE',
      product: 'Leather & Gold',
      series: 'CURATED PIECES',
      image: 'assets/images/onBoarding1_img.png',
      eyebrow: 'CURATED LUXURY',
      title: 'Elevate Your Style',
      description:
          'Discover curated collections of masterfully crafted timepieces, fine jewelry, and timeless accessories tailored to your individuality.',
    ),
    OnboardingSlide(
      brand: 'EVERYDAY ELEGANCE',
      product: 'Modern Leatherwear',
      series: 'TIMELESS STYLE',
      image: 'assets/images/onBoarding2_img.png',
      eyebrow: 'TIMELESS CRAFT',
      title: 'Made for Every Moment',
      description:
          'Explore thoughtful details, refined materials, and enduring designs selected to become part of your story.',
    ),
    OnboardingSlide(
      brand: 'AE ACCESSORIES',
      product: 'Bags, Eyewear & More',
      series: 'THE COLLECTION',
      image: 'assets/images/onBoarding3_img.png',
      eyebrow: 'PERSONAL SERVICE',
      title: 'A Better Way to Shop',
      description:
          'Enjoy a considered shopping experience, with authentic pieces and attentive service from our salon to your door.',
    ),
  ];
}
