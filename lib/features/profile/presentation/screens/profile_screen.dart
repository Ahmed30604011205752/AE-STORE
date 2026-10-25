import 'package:ae_store/core/theme/app_styles.dart';
import 'package:ae_store/core/theme/theme_cubit.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:ae_store/features/auth/presentation/screens/login_screen.dart';
import 'package:ae_store/features/home/presentation/screens/manage_product_screen.dart';
import 'package:ae_store/features/profile/presentation/widgets/custom_profile_item.dart';
import 'package:ae_store/features/profile/presentation/widgets/custom_profile_item_model.dart';
import 'package:ae_store/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileItemModel1> mylist1 = [
    ProfileItemModel1(
      title: 'My Orders',
      icon: Icons.shopping_bag_outlined,
      rightIcon: Icons.arrow_forward_ios,
    ),
    ProfileItemModel1(
      title: 'Wishlist',
      icon: Icons.favorite_border_rounded,
      rightIcon: Icons.arrow_forward_ios,
    ),
    ProfileItemModel1(
      title: 'Shipping Addresses',
      icon: Icons.location_on_outlined,
      rightIcon: Icons.arrow_forward_ios,
    ),
    ProfileItemModel1(
      title: 'Payment Methods',
      icon: Icons.credit_card,
      rightIcon: Icons.arrow_forward_ios,
    ),
  ];

  void cameraBottomSheet(BuildContext context, ThemeData theme) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      builder: (sheetContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: theme.colorScheme.primary),
              title: Text(
                'Take a photo',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
              onTap: () => Navigator.pop(sheetContext),
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: theme.colorScheme.primary,
              ),
              title: Text(
                'Choose from gallery',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
              onTap: () => Navigator.pop(sheetContext),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, _) {
        final theme = Theme.of(context);
        List<ProfileItemModel2> mylist2 = [
          ProfileItemModel2(
            title: 'Settings',
            icon: Icons.settings_outlined,
            rightIcon: Icons.arrow_forward_ios,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              if (mounted) setState(() {});
            },
          ),
          ProfileItemModel2(
            title: 'Manage Products',
            icon: Icons.inventory_2,
            rightIcon: Icons.arrow_forward_ios,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageProductScreen(),
                ),
              );
              if (mounted) setState(() {});
            },
          ),
          ProfileItemModel2(
            title: 'Help and Support',
            icon: Icons.help_outline_rounded,
            rightIcon: Icons.arrow_forward_ios,
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            title: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'MY PROFILE',
                style: AppStyles.style20ExtraBold.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60.5,
                              backgroundImage: const AssetImage(
                                'assets/images/hour.png',
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    cameraBottomSheet(context, theme);
                                  },
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: theme.colorScheme.onPrimary,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'AE STORE',
                          style: AppStyles.style20ExtraBold.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          'ae_store@gmail.com',
                          style: AppStyles.style14Regular.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Card(
                      color: theme.cardColor,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: mylist1.length,
                        itemBuilder: (context, index) {
                          return CustomProfileItems(
                            title: mylist1[index].title,
                            icon: mylist1[index].icon,
                            rightIcon: mylist1[index].rightIcon,
                            color: theme.colorScheme.primary,
                            onTap: () {},
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(color: theme.dividerColor);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Card(
                        color: theme.cardColor,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: mylist2.length,
                          itemBuilder: (context, index) {
                            return CustomProfileItems(
                              title: mylist2[index].title,
                              icon: mylist2[index].icon,
                              rightIcon: mylist2[index].rightIcon,
                              color: theme.colorScheme.primary,
                              onTap: () {
                                (mylist2[index].onTap ?? () {})();
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(color: theme.dividerColor);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Card(
                      color: theme.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomProfileItems(
                          title: 'Log Out',
                          icon: Icons.logout,
                          color: theme.colorScheme.error,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: const Text('Logout?'),
                                content: Text(
                                  'Are you sure you want to logout?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => AuthCubit(),
                                            child: const LoginScreen(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                        color: theme.colorScheme.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
