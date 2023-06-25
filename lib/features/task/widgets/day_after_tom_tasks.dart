import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/common/widgets/widgets.dart';
import 'package:todo/features/task/controllers/_todo/task_provider.dart';
import 'package:todo/features/task/controllers/xpansion_provider.dart';
import 'package:todo/features/task/widgets/tile_todo.dart';

class DayAfterTomorrowTask extends ConsumerWidget {
  const DayAfterTomorrowTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.watch(todoStateProvider.notifier).getRandomColor();
    String dayAfterTomorrow = ref.read(todoStateProvider.notifier).getDayAfterTomorrow();

    var dayAfterTomorrowTasks = todos
        .where((element) => element.date!.contains(dayAfterTomorrow)).toList();
    return CustomExpansionTile(
        onExpansionChanged: (bool expanded){
          ref.read(xpansionState0Provider.notifier).setStart(!expanded);
        },
        trailing: Padding(
          padding:  EdgeInsets.only(right:12.w ),
          child: ref.watch(xpansionState0Provider)
              ?const Icon(AntDesign.circledown, color: Colors.white,)
              :const Icon(AntDesign.closecircle, color: Colors.orange,),
        ),
        text: DateTime.now().add( const Duration(days: 2)).toString().substring(5,10),
        text2: "Day after tomorrow's tasks",
        children: [
          for(final todo in dayAfterTomorrowTasks)
            TodoTile(
              title: todo.title,
              description: todo.description,
              color: color,
              start: todo.startTime,
              end: todo.endTime,
              delete: (){
                ref.read(todoStateProvider.notifier).deleteTodo(todo.id?? 0);
              },
              editWidget: GestureDetector(
                onTap: (){
                },
                child: const Icon(MaterialCommunityIcons.circle_edit_outline, color: Colors.white,),
              ),
              switcher: SizedBox.shrink(),

            ),
        ]
    );
  }
}
