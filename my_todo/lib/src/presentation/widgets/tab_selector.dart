import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_todo/src/data/models/app_tab.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  const TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon((() {
            switch(tab){
              case AppTab.all:
                return Icons.list;
              case AppTab.complete:
                return Icons.check_box;
              default:
                return Icons.check_box_outline_blank;
            }
          }())),
        label: (() {
          switch(tab){
            case AppTab.all:
              return "All";
            case AppTab.complete:
              return "Complete";
            default:
              return "Incomplete";
          }
        }()),
        );
      }).toList(),
    );
  }
}
