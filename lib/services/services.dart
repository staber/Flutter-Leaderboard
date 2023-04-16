import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/services/players_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../secrets.dart';

class Services extends InheritedWidget {
  final PlayersService playersService;

  const Services._({
    required this.playersService,
    required Widget child,
  }) : super(child: child);

  factory Services({required Widget child}) {
    final client = SupabaseClient(supabaseUrl, supabaseKey);
    final playersService = PlayersService(client);
    return Services._(
      playersService: playersService,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static Services of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Services>()!;
  }
}
