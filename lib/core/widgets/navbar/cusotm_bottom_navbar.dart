import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/widgets/navbar/navbar_item.dart';
import 'package:cleanarch/core/widgets/navbar/profile_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _getCurrentIndex(location);

    return Container(
      height: 55,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(25),

        // BorderRadius.only(
        //   bottomRight: Radius.circular(12),
        //   bottomLeft: Radius.circular(12),
        // ),
        boxShadow: [BoxShadow(blurRadius: 10, offset: const Offset(0, 1.5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavbarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            isActive: currentIndex == 0,
            onTap: () => context.go("/posts"),
          ),

          NavbarItem(
            icon: Icons.search,
            activeIcon: Icons.search,
            isActive: currentIndex == 1,
            onTap: () => context.go("/search-post"),
          ),

          ProfileNavItem(
            profileImageUrl: context.watch<CurrentUserCubit>().state?.imageUrl,
            isActive: currentIndex == 2,
            onTap: () => context.go("/user-profile"),
          ),

          _buildFloatingAddButton(context, currentIndex == 0),
        ],
      ),
    );
  }

  Widget _buildFloatingAddButton(BuildContext context, bool showOnPosts) {
    return GestureDetector(
      onTap: () => context.push("/add-post"),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: context.primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }

  /// Determine current tab index from route location
  int _getCurrentIndex(String location) {
    if (location.startsWith("/search-post")) return 1;
    if (location.startsWith("/user-profile")) return 2;
    return 0;
  }
}
