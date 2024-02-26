import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'init/init_cubit.dart';

class AppInit extends StatefulWidget {
  final Future<void> Function() initializeTasks;
  final WidgetBuilder initalizedBuilder;

  const AppInit({
    Key? key,
    required this.initializeTasks,
    required this.initalizedBuilder,
  }) : super(key: key);

  @override
  State<AppInit> createState() => AppInitState();
}

class AppInitState extends State<AppInit> {
  late AppInitializerCubit cubit;

  @override
  void initState() {
    cubit = AppInitializerCubit();
    cubit.initializeTasks(widget.initializeTasks);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInitializerCubit, AppInitializerState>(
      bloc: cubit,
      builder: (context, state) {

        if (state is AppInitializerLoadedState) {
          return widget.initalizedBuilder(context);
        } else if (state is AppInitializerErrorState) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(2, 6, 23, 1),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Error al iniciar la Aplicación',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () =>
                            cubit.initializeTasks(widget.initializeTasks),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Volver a intentar'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xff0c0f30),
                      Color(0xffa21e50),
                    ],
                  ),
                ),
                child: Container()));
      },
    );
  }
}
