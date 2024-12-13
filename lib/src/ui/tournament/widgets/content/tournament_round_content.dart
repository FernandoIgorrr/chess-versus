import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TournamentRoundContent extends StatefulWidget {
  const TournamentRoundContent({super.key});

  @override
  State<TournamentRoundContent> createState() => _TournamentRoundContentState();
}

class _TournamentRoundContentState extends State<TournamentRoundContent> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('ROUND OF TOURNAMENT CONTENT'),
    );
  }
}
