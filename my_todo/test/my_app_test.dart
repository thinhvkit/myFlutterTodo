// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_todo/main.dart';
import 'package:my_todo/src/config/routes/app_routes.dart';
import 'package:my_todo/src/injector.dart';
import 'package:my_todo/src/presentation/blocs/local_task/local_task_bloc.dart';
import 'package:my_todo/src/presentation/blocs/tab/tab_bloc.dart';
import 'package:my_todo/src/presentation/views/tasks_view.dart';

void main() {
  setUpAll(() async {
    await initializeDependencies();
  });

  testWidgets('Should render success MyApp', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    var multiBlocProvider = find.byType(MultiBlocProvider);
    expect(multiBlocProvider, findsOneWidget);
  });

  testWidgets('Should render success TaskView', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<TabBloc>(create: (_) => injector()),
          BlocProvider<LocalTaskBloc>(create: (_) => injector())
        ],
        child: const MaterialApp(
          onGenerateRoute: AppRoutes.onGenerateRoutes,
        ),
      ),
    );

    expect(find.byType(TaskView), findsOneWidget);
  });
}
