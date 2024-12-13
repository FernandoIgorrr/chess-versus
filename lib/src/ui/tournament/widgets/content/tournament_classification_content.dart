import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/ui/custom_app_bar.dart';

class TournamentClassificationContent extends StatefulWidget {
  const TournamentClassificationContent({super.key});

  @override
  State<TournamentClassificationContent> createState() =>
      _TournamentClassificationContentState();
}

class _TournamentClassificationContentState
    extends State<TournamentClassificationContent> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('CLASSIFICATION CONTENT'));
  }
}
