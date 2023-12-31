import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/features/task/controllers/_todo/task_provider.dart';
import 'package:todo/features/task/controllers/xpansion_provider.dart';
import 'package:todo/features/task/pages/update_task.dart';
import 'package:todo/features/task/widgets/tile_todo.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TomorrowTask extends ConsumerWidget {
  const TomorrowTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.watch(todoStateProvider.notifier).getRandomColor();
    String tomorrow = ref.read(todoStateProvider.notifier).getTomorrow();

    var tomorrowTasks = todos
        .where((element) => element.date!.contains(tomorrow)).toList();
    return CustomExpansionTile(
        onExpansionChanged: (bool expanded){
          ref.read(xpansionStateProvider.notifier).setStart(!expanded);
        },
        trailing: Padding(
          padding:  EdgeInsets.only(right:12.w ),
          child: ref.watch(xpansionStateProvider)
              ?const Icon(AntDesign.circledown, color: Colors.white,)
              :const Icon(AntDesign.closecircle, color: Colors.orange,),
        ),
        text: "Tomorrow's Task",
        text2: "Tomorrow's tasks are shown here",
        children: [
          for(final todo in tomorrowTasks)
          TodoTile(
            title: todo.title,
            description: todo.description,
            color: color,
            start: todo.startTime,
            end: todo.endTime,
            delete: (){
              ref.read(todoStateProvider.notifier).deleteTodo(todo.id?? 0);
              showTopSnackBar(
                displayDuration: const Duration(seconds: 1),
                Overlay.of(context),
                CustomSnackBar.success(
                  backgroundColor: Colors.green,
                  textStyle: appStyle(16, Colors.white, FontWeight.w500),
                  message:
                  "Task Deleted Successfully..!",
                ),
              );
              },
            editWidget: GestureDetector(
              onTap: (){
                title = todo.title.toString();
                desc = todo.description.toString();
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateTask(id: todo.id??0),));
              },
              child: const Icon(MaterialCommunityIcons.circle_edit_outline, color: Colors.white,),
            ),
            switcher: SizedBox.shrink(),

          ),
        ]
    );
  }
}
