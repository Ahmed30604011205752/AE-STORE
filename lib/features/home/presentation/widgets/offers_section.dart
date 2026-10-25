import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/features/home/data/models/offer_model.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_cubit.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key, this.onExplore});

  final VoidCallback? onExplore;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) =>
          current is GetOffersLoadingState ||
          current is GetOffersSuccessState ||
          current is GetOffersFailureState,
      builder: (context, state) {
        final offers = state is GetOffersSuccessState
            ? state.offers
            : context.read<ProductsCubit>().offers;
        final offer = offers.isEmpty ? null : offers.first;

        return _OfferBanner(offer: offer, onExplore: onExplore);
      },
    );
  }
}

class _OfferBanner extends StatelessWidget {
  const _OfferBanner({required this.offer, this.onExplore});

  final OfferModel? offer;
  final VoidCallback? onExplore;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 238,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.brandNavy, AppColors.brandInk],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandNavy.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (offer?.imageUrl.isNotEmpty ?? false)
              Opacity(
                opacity: 0.16,
                child: Image.network(
                  offer!.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _BannerBadge(
                        icon: Icons.circle,
                        label: offer?.tag.isNotEmpty == true
                            ? offer!.tag
                            : 'PRIVATE EVENT',
                      ),
                      const Spacer(),
                      const _BannerBadge(
                        icon: Icons.auto_awesome_outlined,
                        label: 'Curated for you',
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    offer?.title.isNotEmpty == true
                        ? offer!.title.toUpperCase()
                        : 'TIMELESS ESSENTIALS',
                    style: AppStyles.style12Medium.copyWith(
                      color: AppColors.onPrimary.withValues(alpha: 0.82),
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    offer?.subtitle.isNotEmpty == true
                        ? offer!.subtitle
                        : 'Discover pieces made to be cherished.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.style22Bold.copyWith(
                      color: AppColors.onPrimary,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 14),
                  FilledButton(
                    onPressed: onExplore,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.onPrimary,
                      foregroundColor: AppColors.brandNavy,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 11,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Explore Collection'),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BannerBadge extends StatelessWidget {
  const _BannerBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 175),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.onPrimary),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.style11Bold.copyWith(color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
