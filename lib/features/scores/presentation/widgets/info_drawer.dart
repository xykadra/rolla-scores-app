import 'package:flutter/material.dart';

import '../../domain/entities/score.dart';

// TODO: This drawer is not drawer that should be implemented as a proper drawer widget.

class InfoDrawer extends StatelessWidget {
  final List<MetricDefinition> definitions;

  const InfoDrawer({super.key, required this.definitions});

  @override
  Widget build(BuildContext context) {
    if (definitions.isEmpty) {
      return const SizedBox.shrink();
    }

    return ExpansionTile(
      title: Text(
        'How it works?',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      children: definitions
          .map(
            (definition) => ListTile(
              title: Text(definition.title),
              subtitle: Text(definition.description),
            ),
          )
          .toList(),
    );
  }
}
