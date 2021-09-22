import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_todo/src/core/bloc/bloc_with_state.dart';
import 'package:my_todo/src/data/models/app_tab.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/presentation/blocs/remote_task/remote_task_bloc.dart';
import 'package:my_todo/src/presentation/blocs/tab/tab_bloc.dart';
import 'package:my_todo/src/presentation/widgets/tab_selector.dart';
import 'package:my_todo/src/presentation/widgets/task_widget.dart';

class TaskView extends HookWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController
          .addListener(() => _onScrollListener(context, scrollController));
      return scrollController.dispose;
    }, [scrollController]);

    return BlocBuilder<TabBloc, AppTab>(builder: (context, activeTab) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(scrollController),
        bottomNavigationBar: TabSelector(
          activeTab: activeTab,
          onTabSelected: (tab) =>
              BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
        ),
      );
    });
  }

  void _onScrollListener(
      BuildContext context, ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final remoteArticleBloc = BlocProvider.of<RemoteTaskBloc>(context);
    final state = remoteArticleBloc.blocProcessState;

    if (currentScroll == maxScroll && state == BlocProcessState.idle) {
      remoteArticleBloc.add(const GetTasks());
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      actions: [
        Builder(
            builder: (context) => GestureDetector(
                  onTap: () => _onShowSaveTaskViewTapped(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Icon(
                      Ionicons.bookmark,
                      color: Colors.black,
                    ),
                  ),
                ))
      ],
    );
  }

  Widget _buildBody(ScrollController scrollController) {
    return BlocBuilder<RemoteTaskBloc, RemoteTaskState>(builder: (_, state) {
      if (state is RemoteTaskLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RemoteTaskError) {
        return const Center(child: Icon(Ionicons.refresh));
      }
      if (state is RemoteTaskDone) {
        return _buildTask(scrollController, state.tasks, state.noMoreData);
      }
      return const SizedBox();
    });
  }

  Widget _buildTask(
      ScrollController scrollController, List<Task> tasks, bool noMoreData) {
    return ListView(controller: scrollController, children: [
      ...List<Widget>.from(tasks.map((e) => Builder(
            builder: (context) => TaskWidget(task: e),
          ))),
      if (noMoreData) ...[
        const SizedBox()
      ] else ...[
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: CupertinoActivityIndicator()),
      ]
    ]);
  }

  void _onShowSaveTaskViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedTaskView');
  }
}
