import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_todo/src/domain/entities/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?>? onCheckboxChanged;
  final bool isRemovable;
  final void Function(Task task)? onRemove;

  const TaskWidget(
      {Key? key,
      required this.task,
      this.onCheckboxChanged,
      this.isRemovable = false,
      this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
          start: 14, end: 14, bottom: 7, top: 7),
      child: Row(
        children: [
          _buildCheckBox(context),
          _buildTitleAndDescription(),
          _buildRemovableArea(),
        ],
      ),
    );
  }

  Widget _buildCheckBox(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Checkbox(
          value: task.complete,
          onChanged: onCheckboxChanged,
        ));
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

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(task);
    }
  }
}
