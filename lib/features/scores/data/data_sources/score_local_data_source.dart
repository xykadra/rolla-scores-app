import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/score_model.dart';

abstract class ScoreLocalDataSource {
  Future<List<ScoreModel>> loadScores();
}

class ScoreLocalDataSourceImpl implements ScoreLocalDataSource {
  final String assetPath;

  ScoreLocalDataSourceImpl({required this.assetPath});

  @override
  Future<List<ScoreModel>> loadScores() async {
    final rawJson = await rootBundle.loadString(assetPath);
    final dynamic decoded = json.decode(rawJson);

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid JSON structure');
    }

    final scoresJson = decoded['scores'] as List<dynamic>? ?? [];
    return scoresJson
        .map((scoreJson) =>
            ScoreModel.fromJson(scoreJson as Map<String, dynamic>))
        .toList();
  }
}
