import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:listradios/pages/app_init.dart';
import 'package:listradios/services/client/api_client.dart';
import 'package:listradios/services/client/api_provider.dart';
import 'package:listradios/style/app_theme.dart';
import 'package:provider/provider.dart';

import '../config/global.dart';
import '../services/repositories/radio_repository.dart';
import 'list_radio/list_radio_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ApiClient apiClient;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerard Radio List',
      theme: Themes.appTheme,
      home: const ListRadioPage(),
      builder: (context, widget) {
        return Provider<Themes>.value(
          value: Themes(),
          child: AppInit(
            initializeTasks: () async {
              await appConfiguration();
            },
            initalizedBuilder: (context) => Provider<ApiClient>.value(
              value: apiClient,
              child: MultiProvider(
                providers: [
                  RepositoryProvider<RadioRepository>(
                    create: (context) => ImplementRadioRepository(
                      apiClient: apiClient,
                    ),
                  ),
                ],
                child: widget!,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> appConfiguration() async {
    final config = GlobalConfig();
    await config.setupConfiguration();
    apiClient = OnApiClient(
      apiProvider: HttpApiRequester(
        client: http.Client(),
        radioUrl: config.baseUrl,
        country: config.country,
      ),
    );
  }
}
