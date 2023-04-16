import 'dart:developer';

import 'package:flutter_application_1/models/player.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class PlayersService {
  static const players = 'players';

  final SupabaseClient _client;

  PlayersService(this._client);

  Future<List<Player>> getPlayers() async {
    //final response = await _client.from(players).select();
    final response = await supabase.from(players).select();
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      return results.map((e) => toPlayer(e)).toList();
    }
    log('Error fetching players: ${response.error!.message}');
    return [];
  }

  Future<Player?> updatePlayer(int id, String title, String? content) async {
    final response = await _client.from(players).update({
      'title': title,
      'content': content,
      'modify_time': 'now()'
    }).eq('id', id);
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      return toPlayer(results[0]);
    }
    log('Error editing player: ${response.error!.message}');
    return null;
  }

  Player toPlayer(Map<String, dynamic> result) {
    return Player(
      result['id'],
      result['first'],
      result['last'],
      result['number'],
      result['avatar'],
      result['shots'],
      result['wrist_roller_reps'],
      result['rebounder_mins'],
    );
  }
}
