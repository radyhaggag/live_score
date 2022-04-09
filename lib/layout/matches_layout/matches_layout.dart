import 'package:flutter/material.dart';
import 'package:live_score/modules/matches_screen/matches_screen.dart';

class MatchesLayout extends StatelessWidget {
  const MatchesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matches"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const MatchesScreen(),
    );
  }
}
