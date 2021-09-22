import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/presentation/blocs/local_task/local_task_bloc.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final bool isRemovable;
  final void Function(Task task)? onRemove;
  final void Function(Task task)? onTaskPressed;

  const TaskWidget(
      {Key? key,
      required this.task,
      this.isRemovable = false,
      this.onTaskPressed,
      this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Container(
          padding:
              const EdgeInsetsDirectional.only(start: 1, end: 1, bottom: 1),
          height: MediaQuery.of(context).size.width / 2.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCheckBox(context),
              _buildTitleAndDescription(),
              _buildRemovableArea(),
            ],
          ),
        ));
  }

  Widget _buildCheckBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Checkbox(
          value: task.complete,
          onChanged: (_) {
            BlocProvider.of<LocalTaskBloc>(context).add(
              UpdateTask(
                task.copyWith(complete: !task.complete),
              ),
            );
          }),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              task.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Butler',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            // Description
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  '',
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemovableArea() {
    if (isRemovable) {
      return GestureDetector(
        onTap: _onRemove,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Ionicons.trash_outline, color: Colors.red),
        ),
      );
    }
    return Container();
  }

  void _onTap() {
    if (onTaskPressed != null) {
      onTaskPressed!(task);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(task);
    }
  }
}
