import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:live_score/layout/cubit/cubit.dart';
import 'package:live_score/layout/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveScoreCubit, LiveScoreStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LiveScoreCubit cubit = LiveScoreCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.getFixtures(
                    DateFormat("y-MM-dd").format(DateTime.now()).toString(),
                  );
                },
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_soccer_rounded),
                label: "Matches",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: "Standings",
              ),
            ],
          ),
        );
      },
    );
  }
}
