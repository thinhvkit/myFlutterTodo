import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_todo/src/data/models/app_tab.dart';
import 'package:my_todo/src/presentation/blocs/tab/tab_bloc.dart';

void main() {
  group(
      'TabBloc',
      () => {
            blocTest('should update the AppTab',
                build: () => TabBloc(),
                act: (TabBloc bloc) async =>
                    bloc.add(const TabUpdated(AppTab.all)),
                expect: () => <AppTab>[AppTab.all])
          });
}
