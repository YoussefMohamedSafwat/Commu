import 'package:cleanarch/core/widgets/navbar/cusotm_bottom_navbar.dart';
import 'package:cleanarch/features/user/presentation/widgets/user_drawer.dart';
import 'package:flutter/material.dart';

class AppBottomNavBar extends StatefulWidget {
  final Widget child;

  const AppBottomNavBar({super.key, required this.child});

  static final _drawerNotifier = ValueNotifier(0);

  static void openDrawer() {
    _drawerNotifier.value++;
  }

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    AppBottomNavBar._drawerNotifier.addListener(_onDrawerRequested);
  }

  void _onDrawerRequested() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void dispose() {
    AppBottomNavBar._drawerNotifier.removeListener(_onDrawerRequested);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: widget.child,
      drawer: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Drawer(child: UserDrawer()),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }
}
