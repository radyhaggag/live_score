import 'package:flutter/material.dart';

import '../../layout/cubit/cubit.dart';

Widget buildLeagueCard(LiveScoreCubit cubit, int index) => Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color.fromARGB(255, 241, 73, 73),
            Color.fromARGB(255, 202, 8, 37),
          ],
        ),
      ),
      child: Row(
        children: [
          Image(
            width: 40,
            height: 40,
            image: NetworkImage(
              cubit.leagues[index].logo!,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            cubit.leagues[index].name!,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
