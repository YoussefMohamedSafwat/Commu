import 'dart:developer';

import 'package:cleanarch/features/Reacts/presentation/cubit/react_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReactRealtimeListener {
  final SupabaseClient client;
  final ReactCubit reactCubit;
  RealtimeChannel? _channel;

  ReactRealtimeListener({required this.client, required this.reactCubit});

  void start() {
    _channel = client.channel('public:posts-counts')
      ..onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'posts',
        callback: (payload) {
          final postId = payload.newRecord['id'] as int;
          final reacts = payload.newRecord['reacts_count'] as int;
          final comments = payload.newRecord['comments_count'] as int;
          reactCubit.applyRemoteCounts(postId, reacts, comments);
        },
      )
      ..subscribe((status, error) {
        log('real time channel status $status, error : $error');
      });
  }

  void stop() => _channel?.unsubscribe();
}
