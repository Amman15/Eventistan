import 'package:eventistan/providers/go_router.dart';
import 'package:eventistan/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as fr;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();

  await FlutterFlowTheme.initialize();

  final appState = FFAppState();
  await appState.initializePersistedState();

  Stripe.publishableKey =
      "pk_test_51PPtLcKvItAx5kdy3J1Q3wEiZhvkqr3bPGeQSxd3dSrRyQK6RP5XE4GOMbxSiKsGHE1zw8EggOesrAn2Bn09OKwh004SeMw3li";

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => appState,
      child: fr.ProviderScope(
        observers: [Logger()],
        child: const App(),
      ),
    ),
  );
}

class App extends fr.ConsumerStatefulWidget {
  const App({super.key});

  @override
  fr.ConsumerState<fr.ConsumerStatefulWidget> createState() => _AppState();

  static fr.ConsumerState<App> of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>()!;
}

class _AppState extends fr.ConsumerState<App> {
  final ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: "Eventistan",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
