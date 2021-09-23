import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_todo/src/data/models/app_tab.dart';
import 'package:my_todo/src/data/models/visibility_filter.dart';
import 'package:my_todo/src/presentation/blocs/local_task/local_task_bloc.dart';
import 'package:my_todo/src/presentation/blocs/remote_task/remote_task_bloc.dart';
import 'package:my_todo/src/presentation/blocs/tab/tab_bloc.dart';
import 'package:my_todo/src/presentation/widgets/tab_selector.dart';
import 'package:my_todo/src/presentation/widgets/task_widget.dart';

class TaskView extends HookWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(builder: (context, activeTab) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
        bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => {
                  () {
                    BlocProvider.of<TabBloc>(context).add(TabUpdated(tab));
                    VisibilityFilter filter = VisibilityFilter.all;
                    switch (tab) {
                      case AppTab.incomplete:
                        filter = VisibilityFilter.active;
                        break;
                      case AppTab.complete:
                        filter = VisibilityFilter.completed;
                        break;
                      default:
                        filter = VisibilityFilter.all;
                    }
                    BlocProvider.of<LocalTaskBloc>(context)
                        .add(FilterUpdated(filter));
                  }()
                }),
      );
    });
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      actions: [
        Builder(
            builder: (context) => GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                  ),
                ))
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<RemoteTaskBloc, RemoteTaskState>(builder: (_, state) {
      if (state is RemoteTaskLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RemoteTaskError) {
        return const Center(child: Icon(Ionicons.refresh));
      }
      if (state is RemoteTaskDone) {
        return _buildTask();
      }
      return const SizedBox();
    });
  }

  Widget _buildTask() {
    return BlocBuilder<LocalTaskBloc, LocalTaskState>(builder: (_, state) {
      if (state is LocalTaskLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is LocalTaskDone) {
        return ListView(children: [
          ...List<Widget>.from(state.tasks.map((e) => Builder(
                builder: (context) => TaskWidget(
                  task: e,
                  onCheckboxChanged: (_) {
                    BlocProvider.of<LocalTaskBloc>(context).add(
                      UpdateTask(e.copyWith(complete: !e.complete)),
                    );
                  },
                ),
              ))),
        ]);
      }
      return const SizedBox();
    });
  }
}
