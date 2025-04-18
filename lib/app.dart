import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'router/navigation_bar.dart';

final _router = GoRouter(
  initialLocation: '/main',
  routes: [
    GoRoute(path: '/main', builder: (context, state) => const AppScaffold()),
  ],
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'CodForge Assignment',
      theme: ThemeData(useMaterial3: true),
    );
  }
}
