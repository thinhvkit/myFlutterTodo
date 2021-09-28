import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/src/config/routes/app_routes.dart';
import 'package:my_todo/src/config/themes/app_theme.dart';
import 'package:my_todo/src/core/utils/constants.dart';
import 'package:my_todo/src/injector.dart';
import 'package:my_todo/src/presentation/blocs/local_task/local_task_bloc.dart';
import 'package:my_todo/src/presentation/blocs/tab/tab_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TabBloc>(create: (_) => injector()),
          BlocProvider<LocalTaskBloc>(create: (_) => injector()..add(const GetAllTasks()))
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: kMaterialAppTitle,
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            theme: AppTheme.light));
  }
}
