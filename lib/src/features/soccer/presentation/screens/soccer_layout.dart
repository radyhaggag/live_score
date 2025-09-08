import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/config/app_route.dart';

import '../../../../core/utils/app_strings.dart';

class SoccerLayout extends StatelessWidget {
  const SoccerLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith(Routes.soccer)) {
      currentIndex = 0;
    } else if (location.startsWith(Routes.fixtures)) {
      currentIndex = 1;
    } else if (location.startsWith(Routes.standings)) {
      currentIndex = 2;
    }

    final List<String> titles = [
      AppStrings.liveScore,
      AppStrings.fixtures,
      AppStrings.standings,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(titles[currentIndex])),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(Routes.soccer);
              break;
            case 1:
              context.go(Routes.fixtures);
              break;
            case 2:
              context.go(Routes.standings);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer_rounded),
            label: AppStrings.fixtures,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: AppStrings.standings,
          ),
        ],
      ),
    );
  }
}
