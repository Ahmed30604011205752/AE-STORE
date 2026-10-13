class OnboardingSlide {
  const OnboardingSlide({
    required this.brand,
    required this.product,
    required this.series,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String brand;
  final String product;
  final String series;
  final String eyebrow;
  final String title;
  final String description;

  static const all = [
    OnboardingSlide(
      brand: 'LUMINOR CHRONO',
      product: 'Titanium & Leather',
      series: 'LIMITED SERIES',
      eyebrow: 'CURATED LUXURY',
      title: 'Elevate Your Style',
      description:
          'Discover curated collections of masterfully crafted timepieces, fine jewelry, and timeless accessories tailored to your individuality.',
    ),
    OnboardingSlide(
      brand: 'ATELIER COLLECTION',
      product: 'Made to Last',
      series: 'FINE CRAFT',
      eyebrow: 'TIMELESS CRAFT',
      title: 'Made for Every Moment',
      description:
          'Explore thoughtful details, refined materials, and enduring designs selected to become part of your story.',
    ),
    OnboardingSlide(
      brand: 'AE SIGNATURE',
      product: 'Luxury, Delivered',
      series: 'WORLDWIDE',
      eyebrow: 'PERSONAL SERVICE',
      title: 'A Better Way to Shop',
      description:
          'Enjoy a considered shopping experience, with authentic pieces and attentive service from our salon to your door.',
    ),
  ];
}
