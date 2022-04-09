import 'package:flutter/material.dart';
import 'package:live_score/modules/standings_screen/standings_screen.dart';

class StandingsLayout extends StatelessWidget {
  const StandingsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Standings"),
      ),
      body: const StandingsScreen(),
    );
  }
}
