import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/custom_app_bar.dart';

class TournamentRoundsContent extends StatefulWidget {
  const TournamentRoundsContent({super.key});

  @override
  State<TournamentRoundsContent> createState() =>
      _TournamentRoundsContentState();
}

class _TournamentRoundsContentState extends State<TournamentRoundsContent> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('ROUNDS OF TOURNAMENT'));
  }
}
