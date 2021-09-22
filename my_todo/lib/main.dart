import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/src/config/routes/app_routes.dart';
import 'package:my_todo/src/config/themes/app_theme.dart';
import 'package:my_todo/src/core/utils/constants.dart';
import 'package:my_todo/src/injector.dart';
import 'package:my_todo/src/presentation/blocs/remote_task/remote_task_bloc.dart';

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
    return BlocProvider<RemoteTaskBloc>(
      create: (_) => injector()..add(const GetTasks()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kMaterialAppTitle,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        theme: AppTheme.light
      ),
    );
  }
}